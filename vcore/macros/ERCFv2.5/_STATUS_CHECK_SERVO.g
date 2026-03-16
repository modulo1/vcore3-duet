;; run this after engaging servo
;; when extruder or selector loaded

;; wiggles filament to ensure servo engaged

var ercfExtuderPositon = move.axes[4].userPosition
set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount

M83  ;; relative extrusion mode

;; show ERCF extruder axis (A)
M584 P5 

M400

if global.ercfSelectorLoaded = 1
    echo "Selector loaded."
    while var.ercfLastCount == global.ercfPulseCount
        G1 A1 F{global.ercfSpeedLoadSlow}
        M400
        if var.ercfLastCount != global.ercfPulseCount
            echo "Blinky pulsed. Servo engaged."
            G90
            G1 A{var.ercfExtuderPositon} F{global.ercfSpeedLoadSlow}
            set ercfServoEngaged = 1