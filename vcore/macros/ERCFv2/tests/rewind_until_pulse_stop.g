;; setup variables
set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount

M83  ;; relative extrusion mode
G91

;=== disable blinky as filament monitor ===;
;; using blinky as simple trigger on axis A
;M98 P"0:/macros/ERCFv2/SYS_FMON_PRE.g"
M400

;; show ERCF extruder axis (A)
M584 P5 

M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"
M400

while var.ercfLastCount = global.ercfPulseCount
    G1 A-2 F{global.ercfSpeedLoadSlow}

;while true
;    G1 A-1 F{global.ercfSpeedLoadSlow}
;    M400
;    if global.ercfPulseCount != var.ercfLastCount
;        set var.ercfLastCount = global.ercfPulseCount
;        M400
;M400
;echo "Blinky stopped; 2nd pass."

;; reset variables
set global.ercfPulseCount = 0
set var.ercfLastCount = global.ercfPulseCount

while var.ercfLastCount == global.ercfPulseCount
    G1 A1 F{global.ercfSpeedLoadSlow}
    if global.ercfPulseCount != var.ercfLastCount
        G1 A{-global.ercfLengthToPulse} F{global.ercfSpeedLoadFast}
        echo "2nd pass finished."

M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"