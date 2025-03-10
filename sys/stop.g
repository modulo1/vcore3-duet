; stop.g
; called when M0 (Stop) is run (e.g. when a print from SD card is cancelled)

set global.cancelled = true

if {state.currentTool!=-1} ; check if any tools are active
    if #tools[state.currentTool].heaters > 0 & heat.heaters[tools[state.currentTool].heaters[0]].current > heat.coldRetractTemperature
        G91 ; relative positioning
        G1 E-18 F6000 ; retract the filament a bit before lifting the nozzle to release some of the pressure
        M291 P"Retracted 10mm" R"Retracting" S0 T3
        ;G4 S4 ; wait for popup
        G90 ; back to absolute positioning
    else
        M291 P{"Not retracted...  Heater off or below extrude temp  " ^ heat.heaters[1].current ^ " : " ^ heat.coldRetractTemperature ^ "."} R"Retract" S0 T5
        ;G4 S6 ; wait for popup
else
    M291 P"No active tool" R"Check tools" S0 T3

if {!move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed} ; check if the machine is homed
    M291 P"Insufficient axis homed.  Cannot raise or park" R"Parking" S0 T3

else
    if {(move.axes[2].machinePosition) < (move.axes[2].max - 10)} ; check if there's sufficient space to raise head
        M291 P{"Raising head to...  Z" ^ (move.axes[2].machinePosition+5)}  R"Raising head" S0 T2
        G91 ; relative positioning
        G1 Z30 F1800 ; move Z up a bit
        G90 ;absolute positioning
    else
        M291 P{"Cannot raise head - insufficient space  " ^ move.axes[2].machinePosition ^ " : " ^ (move.axes[2].max - 10) ^ "."} R"Raising head" S0 T3
    ;G4 S4 ; wait for popup to display
    G90 ;Absolute positioning
    M291 P{"Parking head at X:" ^ (move.axes[0].min + 25) ^ " Y:" ^ (move.axes[1].max - 25)} R"Parking" S0 T3
    G1 X{move.axes[0].min + 25} Y{move.axes[1].max - 25} F1800; parks X head pushes bed out to front so you can pull part
    M400 ; wait for current moves to finish

while iterations < #move.extruders
    M221 S100 D{iterations} ;set extrusion to 100% on all extruders

M220 S100 ; Set speed factor to 100%
M290 R0 S0 ; clear babystepping

M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
M106 S0 ; turn off fan

M84 ; steppers off
G90 ; absolute positioning

; chamber LEDs off
M98 P"0:/macros/LEDs/4_LED-off.g"

G29 S2 ; clear bed mesh

;M292
;G4 S10

M98 P"0:/macros/songs/endPrint.g"  ; play finish tune
set global.cancelled = false
