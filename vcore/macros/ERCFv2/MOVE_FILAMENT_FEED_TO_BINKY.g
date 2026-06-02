;; engage gate servo
;; feed filament to cutter slowly
;; engage cutter

;; setup variables
set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount

M83  ;; relative extrusion mode
G91

;=== disable binky as filament monitor ===;
;; using binky as simple trigger on axis A
;M98 P"0:/macros/ERCFv2/SYS_FMON_PRE.g"
M400

;; show ERCF extruder axis (A)
M584 P5 

;; engage filament gate servo
if global.ercfServoEngaged = 0
    M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"
else 
    M400

G4 S1

;; load filament

while var.ercfLastCount == global.ercfPulseCount
        G1 A1 F{global.ercfSpeedLoadFast}
        M400
        if var.ercfLastCount != global.ercfPulseCount
            echo "Binky reached"
            set global.ercfSelectorLoaded = 1            ;; if the binky can be reached, the selector is loaded
            ;G1 A-12
        else
            echo "No movement.  Servo engaged?"
            continue
;M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"
G90

;M98 P"0:/macros/ERCFv2/SYS_FMON_POST.g"
M400