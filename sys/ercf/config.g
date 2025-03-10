;;;; sacrifical colons. delete or add semicolons to this line and save
;if you're too lazy to type M999
; config.g by omtek

;; current configuration is using bonded extruder drives on RRF36 & CannedERCF
;; gizmoN definition handles toolhead extruder - settings are parameterized here

;=== CAN-FD Bus ===;
;; 19. CannedERCF
;; 20. RRF36 Toolboard
;; 0.  mainboard

;=== external configurations referenced ===;
;; M98 P"0:/sys/ercf/init.g

;=== pin names created with M950 ===;
;; E0 = toolhead LED (20.rgbled)
;; P0 = Dayspring LEDs (0.out5)
;; F1 = 4028 part-cooling fan (0.out4+0.out4.tach)
;; F0 = tool fan (20.out2)
;; === ERCF === ;;
;; S10 = tophat servo (19.io0.out)
;; S5 = filament cutter (0.out6)
;=== interrupt triggers used ===;

;; T9 = trigger9.g, used for ERCF Blinky

;=== initialize variables ===;
M98 P"0:/sys/ercf/init.g"

;=== configuration - ERCF - drive & axis mapping ===;
M569 P19.0 S1 D2                                                               ;; ERCF Selector
M569 P19.1 S0 D2                                                               ;; ERCF Drive
M584 E20.0:19.1 V19.0                                                          ;; gizmoN extruder and ERCF drive are bonded together, selector is V-axis

;=== configuration - ERCF - drive - steps/mm, current, idle timeout ===;
M350 E{move.extruders[0].microstepping.value, 16} V16 I1
M906 E{move.extruders[0].current, 1400} V1400 I30
M92 E{move.extruders[0].stepsPerMm, 549.70} V80

;=== configuration - ERCF - drive - speed, acceeleration, jerk ===;
M201 E{move.extruders[0].acceleration, 3000} V3000
M203 E{move.extruders[0].speed, 1800} V7200
M205 E{move.extruders[0].jerk, 5.0} V5.0

;=== configuration - ERCF - axis - endstops ===;
M574 V1 S1 P"19.io3.in"

;=== configuration - ERCF - axis - min/max ===;
M208 V0 S1
M208 V200 S0

;=== configuration - ERCF - servo, blinky ===;
M591 D1 P7 C"^19.io1.in" S1 A1 L1.000                                         ;; pulsed filament monitor on CannedERCF, Binky mod
M950 S10 C"19.io0.out"                                                        ;; cannedERCF servo
M950 S5 C"0.out6"                                                             ;; filament cutter,

;=== configuration - ERCF - tool definitions ===;
M563 P0 D0:1 H1 F1 L0; define tool 0
G10 P0 R0 S0


M563 P0 S"ERCF_0" D0:1 H1 F1 L1                                               ;; define and name tool
                                                                              ;; assign orbiter/ERCF as extruder drive
G10 P0 R0 S0                                                                  ;; set active & standby temperatures

M563 P1 S"ERCF_1" D0:1 H1 F1 L1                                               ;; define and name tool
                                                                              ;; assign orbiter/ERCF as extruder drive
G10 P1 R0 S0                                                                  ;; set active & standby temperatures

M563 P2 S"ERCF_2" D0:1 H1 F1 L1                                               ;; define and name tool
                                                                              ;; assign orbiter/ERCF as extruder drive
G10 P2 R0 S0                                                                  ;; set active & standby temperatures

M563 P3 S"ERCF_3" D0:1 H1 F1 L1                                               ;; define and name tool
                                                                              ;; assign orbiter/ERCF as extruder drive
G10 P3 R0 S0                                                                  ;; set active & standby temperatures

M563 P4 S"ERCF_4" D0:1 H1 F1 L1                                               ;; define and name tool
                                                                              ;; assign orbiter/ERCF as extruder drive
G10 P4 R0 S0                                                                  ;; set active & standby temperatures

M563 P5 S"ERCF_5" D0:1 H1 F1 L1                                               ;; define and name tool
                                                                              ;; assign orbiter/ERCF as extruder drive
G10 P5 R0 S0                                                                  ;; set active & standby temperatures

M563 P6 S"ERCF_6" D0:1 H1 F1 L1                                               ;; define and name tool
                                                                              ;; assign orbiter/ERCF as extruder drive
G10 P6 R0 S0                                                                  ;; set active & standby temperatures

M563 P7 S"ERCF_7" D0:1 H1 F1 L1                                               ;; define and name tool
                                                                              ;; assign orbiter/ERCF as extruder drive
G10 P7 R0 S0                                                                  ;; set active & standby temperatures

;=== housekeeping ===:
T0 P0                                                                         ;; select Tool 0, don't run toolchange macros
;add to M720.g
M715 S0                                                                       ;; ensure filament top hat servo is open so we can home
G4 S1
M715 S0                                                                       ;; ensure filament top hat servo is open so we can home
M716 S0                                                                       ;; ensure filament cutter is ready for cutting
