echo "entering pre-heat macro"

;=== filament - housekeeping ===;
M106 S0 ; part fan off
set global.cancelled = false

if state.currentTool=-1
	M291 R"No active tool" P"No active tool.  OK to select T0, CANCEL to abort" S3
	T0 P0                                                                                      ;; set T0 active, don't run toolchange macros

if (move.extruders[state.currentTool].filament == "") && (global.LoadedFilament="No_Filament") ;; no filament loaded and none set in variable
	M302 S210 R150                                                                             ;; modify these temps as required to suit most filaments used
	set global.bedPreheatTemp=60                                                               ;; set the default bed temp
	M291 R"No filament" P"No filament loaded.  Setting to defaults" S0 T3
	G4 S3	
	M291 R"Preheating" P{"Setting preheat temperatures for " ^ global.LoadedFilament} S0 T3

else
	echo "Pre-heat macro - loading config for " ^  global.LoadedFilament
	M98 P{"0:\filaments\" ^ global.LoadedFilament ^ "\config.g"} ; load config to get extrude temps etc

var targetTemp = heat.coldExtrudeTemperature+10

;=== filament - heating ===;
echo "setting pre-heat temps"

if !exists(param.F)
	M140 S{global.bedPreheatTemp} R{floor(global.bedPreheatTemp*0.75)}
M568 P{state.currentTool} R{heat.coldRetractTemperature+5} S{var.targetTemp} A2 				;; set nozzle temp , standby and make active

G4 S3

;=== filament - progress state ===;
var thisHeater = tools[state.currentTool].heaters[0]                                            ;;show progress of heating from lower temp

while (heat.heaters[tools[state.currentTool].heaters[0]].current) < (var.TargetTemp - 2)
	M291 R"Preheating..  Please wait" P{"Current temp = " ^  heat.heaters[{var.thisHeater}].current ^ " : target = " ^ (var.targetTemp) }  S0 T2
	G4 S1.8
	if global.cancelled = true
		M108
		M98 P"0:/macros/heating/all_heaters_off.g"
		abort "heating cancelled"

if  (heat.heaters[{var.thisHeater}].current) > (var.TargetTemp + 1)                             ;;show progress of cooling from hotter temp
	echo "Fan on to help cooling faster"
	M106 S0.5
	
while  (heat.heaters[{var.thisHeater}].current) > (var.TargetTemp + 2)	
	M291 R"Preheating..  Please wait" P{"Current temp = " ^  heat.heaters[{var.thisHeater}].current ^ " : target = " ^ (var.TargetTemp)}  S0 T2
	G4 S1.8
	if global.Cancelled = true
		M108
		M98 P"0:/macros/heating/all_heaters_off.g"
		abort "heating cancelled"
		
echo "nozzle temp done"
M106 S0 ; part fan off

;=== filament - parameter declaration ===;                                                       ;;if an F parameter is passed, this is a filament change so no bed heating is done

if !exists(param.F)
	while  (heat.heaters[0].current > global.bedPreheatTemp + 3) || (heat.heaters[0].current < global.bedPreheatTemp - 3)
		M291 R"Waiting for bed..." P{"Current temp = " ^  heat.heaters[0].current ^ " : target = " ^ (global.bedPreheatTemp)}  S0 T2
		G4 S3
		if global.cancelled = true
			M98 P"0:/macros/heating/all_heaters_off.g"
			abort "heating cancelled"
	M98 P"0:/macros/heating/soak_bed.g" ; wait for soak time
echo "waiting for pre-heat temps"
M116 ; wait for temps to settle
M291 R"Preheating" P"Preheating... Done" S0 T2
echo "exiting pre-heat macro"