;; engage gate servo
;; feed filament to cutter slowly
;; engage cutter

;; setup variables
set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount

M83  ;; set relative extrusion mode
G91

;=== disable blinky as filament monitor ===;
;; using blinky as simple trigger on axis A
;M98 P"0:/macros/ERCFv2/SYS_FMON_PRE.g"

;; show ERCF extruder axis (A), reset position

M584 P5 

G92 A0

;; engage filament gate servo
M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"
M400

G4 S1 
;; load filament

while iterations < 20
    if var.ercfLastCount == global.ercfPulseCount 
        ;set var.ercfLastCount = global.ercfPulseCount    
        G1 A2 F{global.ercfLoadSpeedSlow}
        M400
        if global.ercfPulseCount != var.ercfLastCount
            G4 S2
            echo "Pulse count: " ^ global.ercfPulseCount
            echo "Amount fed: " ^ move.axes[4].userPosition
            G1 A{-move.axes[4].userPosition} F{global.ercfLoadSpeedSlow}

M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"

M584 P4

G90

;M98 P"0:/macros/ERCFv2/SYS_FMON_POST.g"