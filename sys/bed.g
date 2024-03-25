; bed.g
; called to perform automatic bed compensation via G32

M290 R0 S0                                                                                 ;; clear baby stepping
M561                                                                                       ;; reset all bed adjustments
M400                                                                                       ;; flush move queue


if !move.axes[0].homed 
  echo "not all axes homed, homing axes first"                                             ;; Home XYZ, if not already
  G28

M401

;=== probe sanity check commands ===;
;; G1 X{ 20 - sensors.probes[0].offsets[0] }  Y{ 20 - sensors.probes[0].offsets[1] }
;; G1 X{ 170 - sensors.probes[0].offsets[0] }  Y{ 275 - sensors.probes[0].offsets[1] }
;; G1 X{ 280 - sensors.probes[0].offsets[0] }  Y{ 40 - sensors.probes[0].offsets[1] }


;=== rough pass estimate, can skip ===;
G30 P0 X20 Y20 Z-99999          ; probe near a leadscrew
G30 P1 X170 Y275 Z-99999        ; probe near a leadscrew
G30 P2 X280 Y40 Z-99999 S3      ; probe near a leadscrew and calibrate 3 motors
echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

while move.calibration.initial.deviation > 0.005
    if iterations >= 10
        echo "Error: Max attempts failed. Deviation: " ^ move.calibration.initial.deviation
        break
    echo "Deviation over threshold. Executing pass" , iterations+1, "deviation", move.calibration.initial.deviation
    G30 P0 X20 Y20 Z-99999 ; probe near a leadscrew
    G30 P1 X170 Y275 Z-99999 ; probe near a leadscrew
    G30 P2 X280 Y40 Z-99999 S3 ; probe near a leadscrew and calibrate 3 motors
        echo "Current deviation: " ^ move.calibration.initial.deviation 
        continue
echo "Final deviation: " ^ move.calibration.initial.deviation

G0 X150 Y150 F10000
;G1 X{global.Bed_Center_X - sensors.probes[0].offsets[0] } Y{global.Bed_Center_Y - sensors.probes[0].offsets[1]} F12000

; rehome Z as the absolute height of the z plane may have shifted
G28 Z

M402
