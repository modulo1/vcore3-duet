M290 R0 S0    ;  clear baby stepping
M561          ;  reset all bed adjustments
M400          ;  flush move queue

if !move.axes[0].homed or !move.axes[1].homed or !move.axes[2].homed
  echo "not all axes homed, homing axes first"
  G28
  if result != 0
		abort "Print cancelled due to homing error"
 
while true
  if iterations = 5
    abort "Auto calibration repeated attempts ended, final deviation", move.calibration.final.deviation ^ "mm"
  G30 P0 X10 Y10 Z-99999 ; probe near a leadscrew
  if result != 0
    continue
  G30 P1 X150 Y285 Z-99999 ; probe near a leadscrew
  if result != 0
    continue
  G30 P2 X270 Y5 Z-99999 S3 ; probe near a leadscrew and calibrate 3 motors
  if result != 0
    continue
  if move.calibration.initial.deviation <= 0.01
    break
  echo "Repeating calibration because deviation is too high (" ^ move.calibration.initial.deviation ^ "mm)"
; end loop
echo "Auto calibration successful, deviation", move.calibration.final.deviation ^ "mm"

;G0 X150 Y150 F10000
;G1 X{global.Bed_Center_X - sensors.probes[0].offsets[0] } Y{global.Bed_Center_Y - sensors.probes[0].offsets[1]} F12000

; rehome Z as the absolute height of the z plane may have shifted

G28 Z
