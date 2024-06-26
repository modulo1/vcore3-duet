;; gizmoN.g is the comprehensive definition of a tool (extruder, hotend, heater, thermisistor, filament monitoring, input shaping, tool and part cooling fans)
;; includes hotend (thermistor, heater), fan (tool, part), extruder (axis, microstepping), tool assignment and offset

;=== gizmo1 - fan ===;
M950 F1 C"!0.out4+0.out4.tach"                                                ;; create fan F1 named "4028" with duet.out4+duet.out4.tach (0.out4+0.out4.tach)
M106 P1 C"4028" S0 H-1

;=== gizmo1 - hotend thermistor ===;

M308 S1 P"20.temp0" Y"thermistor" T100000 B4725 C7.060000e-8 A"e3drevo"       ;; configure sensor 1 (S1) on pin RRF36.temp0 (20.temp0) as thermistor
M950 H1 C"20.out0" T1                                                         ;; create heater output (H1) on RRF36.out0 (20.out0) and map to sensor 1 (T1)
M307 H1 B0 S1.00                                                              ;; set PWM limit (S1.00)
M563 P0 S"revo" D0 H1 F1                                                      ;; define tool0 (T0)
                                                                              ;; assign fan F1, extruder drive D0 (E0) and heater H1 to tool T0 named "revo"
G10 P0 X0 Y0 Z0                                                               ;; set axis offsets, max temperature, initial temperature
M143 H1 S280
G10 P0 R0 S0

;=== gizmo1 - fan ===;
M950 F1 C"!0.out4+0.out4.tach"                                                ;; create fan F1 named "4028" with duet.out4+duet.out4.tach (0.out4+0.out4.tach)
M106 P1 C"4028" S0 H-1

;=== gizmo1 - hotend thermistor ===;
M308 S1 P"20.temp0" Y"thermistor" T100000 B4725 C7.060000e-8 A"e3drevo"       ;; configure sensor 1 (S1) on pin RRF36.temp0 (20.temp0) as thermistor
M950 H1 C"20.out0" T1                                                         ;; create heater output (H1) on RRF36.out0 (20.out0) and map to sensor 1 (T1)
M307 H1 B0 S1.00                                                              ;; set PWM limit (S1.00)
M563 P0 S"revo" D0 H1 F1                                                      ;; define tool0 (T0)
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

;=== gizmo1 - fan - hotend ===;
M950 F0 C"20.out2" Q250                                                       ;; create fan 0 (F0) on pin RRF.out2 (20.out2)
M106 P0 C"tool" S0 H1 T45 L255                                                ;; set fan 0 (P0) to thermostatic control (45C), full-speed (L255) named "tool"

;=== gizmo1 - extruder ===;
                                                                              ;; Orbiter v2 with LDO motor
M906 E1200 I10                                                                ;; set extruder motor current and idle factor
M350 E16 I1                                                                   ;; set microstepping to 16 with interpolation
M92 E671.64                                                                   ;; set extruder steps per mm
M203 E7200                                                                    ;; set max speed, jerk, acceleration
M205 E5.0
M201 E3000

T0 P0                                                                         ;; select T0, don't run toolchange macro

M703                                                                          ;; load filament specific gcode
                                                                              ;; I keep filament-specific PID tuning, retraction, and pressure advance 
                                                                              ;; settings here.
                                                                              
;=== gizmo1 - options ===;
M955 P20.0 I12                                                                ;; accelerometer on RRF36
M950 E0 C"20.rgbled" T2 U2 Q3000000                                           ;; configure toolhead LED E0 on FLY36.rgbled (20.rgbled)
;M98 P"0:/sys/setFilamentMonitor.g"                                           ;; filament monitor
;M98 P"0:/sys/setInputShaping.g"                                              ;; input shaping parameters
