;; gizmoN.g is the comprehensive definition of a tool (extruder, hotend, heater, thermisistor, filament monitoring, input shaping, tool and part cooling fans)
;; includes hotend (thermistor, heater), fan (tool, part), extruder (axis, microstepping), tool assignment and offset

M550 P"legionXY - gizmo5"

;=== gizmo4 - fan ===;
M950 F1 C"!0.out4+0.out4.tach"                                                ;; create fan F1 named "4028" with duet.out4+duet.out4.tach (0.out4+0.out4.tach)
M106 P1 C"4028" S0 H-1

;=== gizmo4 - hotend thermistor ===;
M308 S1 P"20.temp0" Y"thermistor" T100000 B4725 C7.060000e-8 A"dragonSF_60W"       ;; configure sensor 1 (S1) on pin RRF36.temp0 (20.temp0) as thermistor
M950 H1 C"20.out0" T1                                                         ;; create heater output (H1) on RRF36.out0 (20.out0) and map to sensor 1 (T1)
M307 H1 B0 S1.00                                                              ;; set PWM limit (S1.00)
M563 P0 S"superlight" D0 H1 F1                                               ;; define tool0 (T0)
                                                                              ;; assign fan F1, extruder drive D0 (E0) and heater H1 to tool T0 named "revo"
G10 P0 X0 Y0 Z0                                                               ;; set axis offsets, max temperature, initial temperature
M143 H1 S290
G10 P0 R0 S0

;=== !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ===;
;; run hotend PID tune!! using code below
;;; T0 = PID tune tool0
;;; S210 = temperature in C (210C)
;;; F0.45 = Fan PWM value; 0.45 = 45%
;;; ; M303 T0 S210 F0.45
;;; replace M307 below with results from M303
;=== !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ===;
M307 H1 R3.611 K0.702:0.541 D1.95 E1.35 S1.00 B0 V23.5                        ;; this is my M307, find your own

;=== gizmo4 - fan - hotend ===;
M950 F0 C"20.out2" Q250                                                       ;; create fan 0 (F0) on pin RRF.out2 (20.out2)
M106 P0 C"tool" S0 H1 T45 L255                                                ;; set fan 0 (P0) to thermostatic control (45C), full-speed (L255) named "tool"

;=== gizmo4 - extruder ===;
M569 P20.0 S0 D2                                                              ;; Extruder, RRF36.driver0
                                                                              ;; VZ-Hextrudort Low with LDO motor
M906 E1000                                                                    ;; set extruder motor current
M350 E16 I1                                                                   ;; set microstepping to 16 with interpolation
M92 E704.53
M203 E7200                                                                    ;; set max speed, jerk, acceleration
M205 E5.0
M201 E3000

T0 P0                                                                         ;; select T0, don't run toolchange macro

M703                                                                          ;; load filament specific gcode
                                                                              ;; I keep filament-specific PID tuning, retraction, and pressure advance
                                                                              ;; settings here.

;=== configuration - scanning z-probe ===;
M558 K1 P11 C"20.i2c.ldc1612" F18000 T36000
M308 A"SZP" S4 Y"thermistor" P"20.temp1" T100000 B4092; thermistor on PCB/coil
M98 P"0:/sys/configSZPCoil.g"                                                 ;; M558.2 settings go here to set drive level

;=== gizmo1 - options ===;
M955 P20.0 I12                                                                ;; accelerometer on RRF36
M950 E0 C"20.rgbled" T2 U2 Q3000000                                           ;; configure toolhead LED E0 on FLY36.rgbled (20.rgbled)
;M98 P"0:/sys/configFilamentMonitor.g"                                           ;; filament monitor
M98 P"0:/sys/configInputShaping.g"                                              ;; input shaping parameters
