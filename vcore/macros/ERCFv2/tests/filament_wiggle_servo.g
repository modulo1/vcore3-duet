;; setup variables
set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount

;=== show ERCF extruder axis ===;
M584 P5
G92 A9999

G91

;; engage servo
M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"

if global.ercfExtruderLoaded = 1
    G1 A-2 E-2 F{global.ercfLoadSpeedSlow}
    if global.ercfPulseCount != var.ercfLastCount
        echo "Servo engaged: ok to proceed..."
        break
else
    G1 A-2 F{global.ercfLoadSpeedSlow}
    if global.ercfPulseCount != var.ercfLastCount
    echo "Servo engaged: ok to proceed..."
    break
