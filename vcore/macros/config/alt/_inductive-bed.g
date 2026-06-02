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
;; G1 X{ 160 - sensors.probes[0].offsets[0] }  Y{ 280 - sensors.probes[0].offsets[1] }
;; G1 X{ 270 - sensors.probes[0].offsets[0] }  Y{ 30 - sensors.probes[0].offsets[1] }

;; G1 X{ 10 - sensors.probes[1].offsets[0] }  Y{ 20 - sensors.probes[1].offsets[1] }
;; G1 X{ 155 - sensors.probes[1].offsets[0] }  Y{ 290 - sensors.probes[1].offsets[1] }
;; G1 X{ 290 - sensors.probes[1].offsets[0] }  Y{ 20 - sensors.probes[1].offsets[1] }

;M98 P"0:/macros/config/configSZPnormal.g"
;M98 P"0:/macros/config/configSZPtouch.g"

;=== rough pass estimate - inductive ===;
G30 K0 P0 X30 Y30 Z-99999          ; probe near a leadscrew
G30 K0 P1 X155 Y270 Z-99999        ; probe near a leadscrew
G30 K0 P2 X270 Y30 Z-99999 S3      ; probe near a leadscrew and calibrate 3 motors
echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

;=== rough pass estimate - SZP touch===;
;G30 K1 P0 X30 Y30 Z-99999          ; probe near a leadscrew
;G30 K1 P0 X10 Y20 Z-99999          ; probe near a leadscrew
;G30 P0 X30 Y25 Z-99999            ; probe on the leadscrew
;G30 K1 P1 X155 Y270 Z-99999        ; probe near a leadscrew
;G30 K1 P1 X155 Y290 Z-99999        ; probe near a leadscrew
;G30 P1 X160 Y275 Z-99999        ; probe near a leadscre
;G30 K1 P2 X270 Y30 Z-99999 S3      ; probe near a leadscrew and calibrate 3 motors
;G30 K1 P2 X290 Y20 Z-99999 S3      ; probe near a leadscrew and calibrate 3 motors
;G30 P2 X280 Y25 Z-99999 S3      ; probe near a leadscrew and calibrate 3 motor
;echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

;=== rough pass estimate - inductive ===;
while move.calibration.initial.deviation > 0.005
    if iterations >= 10
        echo "Error: Max attempts failed. Deviation: " ^ move.calibration.initial.deviation
        break
    G30 K0 P0 X30 Y30 Z-99999 ; probe near a leadscrew
    G30 K0 P1 X155 Y270 Z-99999 ; probe near a leadscrew
    G30 K0 P2 X270 Y30 Z-99999 S3 ; probe near a leadscrew and calibrate 3 motors
        echo "Current deviation: " ^ move.calibration.initial.deviation
        continue
echo "Final deviation: " ^ move.calibration.initial.deviation


;=== rough pass estimate - SZP touch===;
;while move.calibration.initial.deviation > 0.005
;    if iterations >= 10
;        echo "Error: Max attempts failed. Deviation: " ^ move.calibration.initial.deviation
;        break
;    echo "Deviation over threshold. Executing pass" , iterations+1, "deviation", move.calibration.initial.deviation
;    G30 K1 P0 X10 Y20 Z-99999 ; probe near a leadscrew
;    G30 K1 P1 X155 Y290 Z-99999 ; probe near a leadscrew
;    G30 K1 P2 X290 Y20 Z-99999 S3 ; probe near a leadscrew and calibrate 3 motors
;        echo "Current deviation: " ^ move.calibration.initial.deviation
;        continue
;echo "Final deviation: " ^ move.calibration.initial.deviation
M98 P"0:/macros/songs/charge.g"
G1 X{global.bedCenterX} Y{global.bedCenterY} F12000

; rehome Z as the absolute height of the z plane may have shifted
G28 Z

M402