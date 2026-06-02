;common_unload.g  - direct filament unloading sequence here

echo "entering 0:/macros/filament/universal_unload.g"

M106 S0  ; fan off


;=== homing & movement check - remove this block if you don't want any movement during loading ===;
while iterations < #move.axes                                        ;; home axes so we can move
	if !move.axes[iterations].homed
		G28
		
M400
			
if move.axes[0].homed &&  move.axes[1].homed && move.axes[2].homed  && job.file.fileName = null             ;; check if we're printing; else move to center of printer
	if (move.axes[0].userPosition!=global.bedCenterX) || (move.axes[1].userPosition!=global.bedCenterY) || (move.axes[2].userPosition!=25)
		M291 R"Positioning" P"Move to safe extrude height?" S4 K{"Yes","No",} F0                            ;; currently "safe extrude height" is the center of the bed
		if input = 0                                                                                        ;; with the bed at Z=25
			G1 X{global.bedCenterX} Y{global.bedCenterY} Z25 F3600
			M400
;=== homing & movement check ===;

if state.currentTool==-1
	M291 R"No Tool" P"No tool selected.  OK to unload tool 0, Cancel to abort" S2
	T0 P0
echo "waiting for unload temp"

if (move.extruders[state.currentTool].filament == "") || (global.loadedFilament="") || (global.loadedFilament==null)
	M291 R"Error" P"No filament loaded.  Unload aborted" S2 T2
	M99
	
var targetTemp = heat.coldRetractTemperature + 5

;M291 R{"Unloading " ^ move.extruders[state.currentTool].filament} P"Waiting for nozzle unloading temperature..." S0 T3
M568 P{state.currentTool} S{heat.coldExtrudeTemperature+10} R{var.targetTemp} A1             ;; Heat current tool just enough to cold pull
G4 S3

var thisHeater = tools[state.currentTool].heaters[0]

;=== heating message - this section will setup a blocking message in DWC and PanelDue with current temperature - comment out or delete ===;
while (heat.heaters[tools[state.currentTool].heaters[0]].current) < (var.targetTemp - 1)                     
	M291 R"Preheating..  Please wait" P{"Current temp = " ^  heat.heaters[var.thisHeater].current ^ " : target = " ^ var.targetTemp}  S0 T2
	G4 S1.8
	if global.cancelled = true
		M108
		M98 P"0:/macros/heating/all_heaters_off.g"
		abort "heating cancelled"

if  (heat.heaters[var.thisHeater].current) > (var.targetTemp + 1)
	echo "Fan on to help cooling faster"
	M106 S0.5


while  (heat.heaters[var.thisHeater].current) > (var.targetTemp + 1)                                               ;;show progress of cooling from hotter temp
	M291 R"Preheating..  Please wait" P{"Current temp = " ^  heat.heaters[var.thisHeater].current ^ " : target = " ^ var.targetTemp}  S0 T2
	G4 S1.8
	if global.cancelled = true
		M108
		M98 P"0:/macros/heating/all_heaters_off.g"
		abort "heating cancelled"

;=== heating message end ===;
M106 S0                                                                                            ;; turn off part fan
M116                                                                                               ;; Wait for temperature to be within 0.5 degrees of target

echo "waiting for filament to settle"
;M291 R{"Unloading " ^ move.extruders[state.currentTool].filament} P"Waiting for filament to soften (or firm)..." S0 T10
G4 T10; Wait for additional delay for filament to cool or soften

echo "unloading"
M291 R{"Unloading " ^ move.extruders[state.currentTool].filament} P"Retracting..." S0 T5
M98 P"0:/macros/filament/do_moves_for_unload.g"

M568 P{state.currentTool} S{heat.coldExtrudeTemperature+10} R{var.targetTemp} A2 ; Heat current tool to cold extrude temp
echo "Heating to cold extrude temp..  Please wait"
M116
echo "unloading complete - exiting universal_unload.g"
;M929 S0