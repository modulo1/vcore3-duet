;; engage gate servo
;; feed filament to cutter slowly
;; engage cutter

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

echo "Loading filament to selector on " ^ (tools[global.ercfCurrentSelector].name)

;; engage filament gate servo
if global.ercfServoEngaged = 0
    M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"
else 
    M400

;; load filament



while var.ercfLastCount == global.ercfPulseCount
    ;if global.ercfSelectorLoaded == 0
        ;set var.ercfLastCount = global.ercfPulseCount
        G1 A{global.ercfLengthSelector} F{global.ercfSpeedLoadFast}
        M400
        if var.ercfLastCount != global.ercfPulseCount
            echo "Load finished on " ^ (tools[global.ercfCurrentSelector].name)
            set global.ercfSelectorLoaded = 1
        if iterations = 2
            break "Load failed on " ^ (tools[global.ercfCurrentSelector].name

;if global.ercfServoEngaged = 1
;    M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"
;else 
;    M400

G90

M400
;M98 P"0:/macros/ERCFv2/SYS_FMON_POST.g"