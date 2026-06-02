

set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount

M98 P"0:/macros/ERCFv2/SYS_FMON_PRE.g"
M400

M302 P1

while global.ercfPulseCount = 0
    G1 E0:1 F60

echo "Distance from gate to blinky: " ^ move.extruders[1].position

M98 P"0:/macros/ERCFv2/SYS_FMON_POST.g"
M400

M302 P0