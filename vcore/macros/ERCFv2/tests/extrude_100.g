;; extrude 100mm of filament
;; read result of blinky pulse

set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount

;M98 P"0:/macros/ERCFv2/SYS_FMON_PRE.g"
M400

M584 P5
G92 A0

M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"


G1 A100 F{global.ercfLoadSpeedSlow}
M400

G4 S2

echo "100mm filament extruded"
echo "Blinky pulse count: " ^ global.ercfPulseCount
echo "Number of pulses/mm: " ^ global.ercfPulseCount / 100

M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"

;M98 P"0:/macros/ERCFv2/SYS_FMON_POST.g"
;M400
