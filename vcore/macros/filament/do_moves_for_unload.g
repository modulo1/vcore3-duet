; Unload filament
;echo "begin do_moves_to_unload.g"
var retractDistance = 150 ; must be a positive number high enough to withdraw filament completely from heat break!!
M291 R"Unloading" P"Running do_moves_for_unload" S0 T2
M400 ; wait for any moves
if ({heat.heaters[tools[state.currentTool].heaters[0]].current < heat.coldRetractTemperature-3})
	M291 R"Can't proceed" P"temp to low for extraction" S2 T10
	abort;
M83 ; set relative extrusion
;echo "retracting"
M291 R"Retracting" P"Retracting filament.... Please wait" S1 T30
while iterations < var.retractDistance-1
	G1 E-1 F{global.filamentRetractSpeed} ; retract 1m at a time to clear hotend
	M291 S0 R"Retracting" P{"Retracted " ^ iterations + 1 ^ "mm of " ^ var.retractDistance} T1
M400 ; wait for moves to finish
;echo "retract finished"
M291 R"Ready to change" P"Filament extracted.  Change roll" S0 T5
M568 A0 ; turn off heater
;echo "exiting do_moves_to_unload.g"