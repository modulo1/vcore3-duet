;common_load.g

echo "starting 0:/macros/filament/common_load.g" 

;=== homing & movement check - remove this block if you don't want any movement during loading ===;
while iterations < #move.axes 							        ;; check if we're homed and move to the center
	if !move.axes[iterations].homed
		G28
M400		
														        ;; check if we are at the our defined load/unload position
if (move.axes[0].userPosition!=global.Bed_Center_X) || (move.axes[1].userPosition!=global.Bed_Center_Y) || (move.axes[2].userPosition!=25)
	M291 R"Repositioning" P"Moving to safe extrude height" S2 T2
	G1 X{global.Bed_Center_X} Y{global.Bed_Center_Y} Z25 F3600

M400
;=== homing check ===;

M98 P"0:/macros/LEDs/led_on.g" 							        ;; chamber &  toolhead LEDs on

if state.currentTool=-1                                         ;; check current tool, select T0, don't run toolchange macros
	echo "No tool selected.  Selecting T0"
	T0 P0

;=== filament - load current configuration ===;

M291 R{"Loading " ^ global.LoadedFilament} P"Loading config and heating" S1 T3
G4 S3
echo "loading configuration for " ^ global.LoadedFilament

M98 P{"0:\filaments\" ^ global.loadedFilament ^ "\config.g"} 	 ;; load config for cold extrude temps
if result=0
	echo "configuration loaded successfully"
else
	echo "error loading configuration"

;=== filament - preheat ===;

echo "preheating"

M98 P"0:/macros/heating/preheat_current_filament.g" F1           ;; preheat to the temps set in filament config.g

if result !=0
	echo "Error setting temp"

M291 R{"Loading " ^ global.LoadedFilament} P"Waiting for nozzle loading temperature..." S0 T3

M116                                                             ;; Wait for temperature

echo "waiting for temp to stabilize"

;=== filament - sanity checks ===;                               ;; check if there's filament loaded, and we're not in runout state
																 
if (move.extruders[state.currentTool].filament=global.loadedFilament) && (global.filamentDistance=0)  
	echo "filament loaded.  confirm loading required?"
	M291 R"Continue loading?" P{global.loadedFilament ^ " filament already loaded.  OK to do load moves"} S3
 
if job.file.fileName!=null && state.status!="paused"             ;; option to cancel if we're printing. filament change macro will use seperate logic checks
	echo "Print job is running - confirmation required"
	M291 R"Confirm?" P"A print job is in progress.  Press OK to continue or CANCEL to abort" S3

if {move.extruders[state.currentTool].filament!=""} && {global.filamentDistance=0}
	echo "unload required"
	if move.extruders[state.currentTool].filament!=global.loadedFilament
		M702 S{"{move.extruders[state.currentTool].filament}"}
		M291 R"Unload finished" P"Press OK when ready to load new filament" S3
		echo "another filament loaded, so load new one"
		M701 S{global.loadedFilament}

if state.currentTool=-1											 ;; second sanity check if this is a loop
	echo "No tool selected.  Setting tool 0 active"
	T0 P0
if {move.extruders[state.currentTool].filament!=global.loadedFilament}
	echo "loading filament"
	M291 R{"Loading " ^ global.loadedFilament} P"Feeding and priming..." S0 T3
	G4 S4
	M98 P"0:/macros/filament/do_moves_for_load.g"
	echo "loading complete"

M291 R{"Loading " ^ global.loadedFilament} P"Filament loaded....." S0 T3

G4 S3

;M98 P"0:/macros/songs/simpsons.g"

set global.filamentDistance = 0 ; reset filament sensor extrusion distance after tripping

echo "exiting universal_load.g"

M568 P{state.currentTool} A0 ; turn off heater again