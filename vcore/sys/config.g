

 ;;;; sacrifical colons. delete or add semicolons to this line and save
;if you're too lazy to type M999
; config.g by omtek

;; current configuration ;;
; duet 3 mini 5+ running RRF 3.6.1 standalone
; Mellow Fly SHT36MAX3 Toolboard
; CannedERCF Board
; PanelDue 7i
; Orbiter v2.5
; Rapido 2HF hotend

;=== CAN-FD Bus ===;
;; 19. CannedERCF
;; 20. SHT36MAX3 Toolboard
;;  0. mainboard

;=== external configurations referenced ===;
;; M98 P"0:/macros/config/configInitPre.g"
;; M98 P"0:/macros/config/configInitPost.g"
;; M98 P"0:/macros/config/configMaxSpeed.g"
;; M98 P"0:/macros/config/configHomingSpeed.g"
;; M98 P"0:/macros/config/configBuildPlate.g"
;; M98 P"0:/macros/config/configDefaultProbePoints.g"
;; M98 P"0:/macros/config/configFilamentMonitor.g"
;; M98 P"0:/macros/config/configInputShaping.g"
;; M98 P"0:/macros/config/configSZPnormal.g"
;; M98 P"0:/macros/config/configSZPtouch.g"

;=== sensors referenced with M308 ===;
;; S0 = bed (0.temp0)
;; S1 = hotend (20.max31865cs)
;; S4 = SZP (20.temp1)
;; S5 = BME280 temperature, chamber (0.spi.cs1)
;; S8 = BME280 humidity, chamber (SPI)
;; S10 = BME280 pressure, chamber (SPI)
;; S11 = MCU temperature (0.mcu-temp)

;=== sensor colors as defined by Snnn ===;
; S0 = blue (bed)
; S1 = red (hotend)
; S2 = deep orange
; S4 = teal (SZP)
; S5 = yellow (chamber)
; S6 = purple
; S7 = black
; S8 = lime {humidity)
; S9 = grey
; S10 = orange
; S11 = green (MCU)
; S12 = red???
; S13 = blue???
; S14 = light grey

;=== pin names created with M950 ===;
;; E0 = toolhead LED (20.rgbled)
;; P0 = Dayspring LEDs (0.out1)
;; F1 = 4028 part-cooling fan (0.out2)
;; F0 = tool fan (20.out2)
;; S1 = servo-driven nozzle wiper (0.io1.out)
;; === ERCF === ;;
;; S10 = tophat servo (19.io0.out)
;; S5 = filament cutter (0.vfd)

;=== interrupt triggers used ===;
;; T9 = trigger9.g, used for ERCF Blinky

;=== initialize variables ===;
M98 P"0:/macros/config/configInitPre.g"                                   ;; set some variables that we need for configuration
M400
;=== discard if necessary ===;

;=== configuration - initial networking setup ===;
M586 P0 S1                                                 ;; enable http, disable ftp, disable telnet, set printer name, wait 5s for expansion boards
M586 P1 S0
M586 P2 S0
G4 S5
M550 P"legionXY"                                           ;; in SBC mode, M550 goes in dsf-config.g, not config.g
M552 S1
M122 P500 S0

;=== configuration -  PanelDue init ===;
M575 P1 S4 B57600

;=== configuration - printer ===;
G90                                                        ;; absolute coordinates, relative extruder moves
M83
M669 K1                                                    ;; Kinematics type: 1 = CoreXY

;=== configuration - drive ===;
M569 P0.0 S0 D2                                            ;; Z-axis motors, 0.driver0,0.driver1,0.driver2
M569 P0.1 S0 D2
M569 P0.2 S0 D2
M569 P0.3 S1 D2                                            ;; Left and right motors (X- and Y- axis), 0.driver3,0.driver4
M569 P0.4 S1 D2

;=== configuration - drive - axis mapping ===;
M584 X0.3 Y0.4 Z0.2:0.0:0.1 E20.0                          ;;  map E-axis here as toolboard will be connected

;=== configuration - drive - microstepping ===;
M350 X16 Y16 Z16 I1

;=== configuration - drive - steps/mm, current, idle timeout ===;
M92 X80 Y80 Z800                                          ;; set steps/mm, current (mA), idle timeout


;=== configuration - drive - speed, acceeleration, jerk ===;
M98 P"0:/macros/config/configMaxSpeed.g"                               ;; set all the max speeds below as these are adjusted during home moves so we only want to adjust in one spot
M400

;=== configuration - axis - min/max ===;
M208 X0 Y0 Z0 S1
M208 X310 Y300 Z300 S0

;=== configuration - axis - endstops ===;
M574 X1 S1 P"20.io2.in"                                   ;; configure active high (S1) X endstop at X- (X1) on RRF36.io2.in (20.io.in)
M574 Y2 S1 P"0.io4.in"                                    ;; configure Y active high (S1) endstop at Y+ (Y2) on duet.io2.in (0.io2.in)
M574 Z1 S2                                                ;; configure Z-probe (S2) endstop at low end (Z1)

;=== configuration - axis - z-probe ===;
M558 P8 C"20.io0.in" H5:1 F300:120 T12000 A20 B0 K0         ;; inductive probe installed on RRF36.io0.in (20.io0.in)

;=== configuration - axis - mesh compensation and bed dismensions ===;
;M98 P"0:/sys/configDefaultProbePoints.g"                     ;; define mesh grid with allowance for mesh generation on printed area only
M557 X10:290 Y10:290 P20                                      ;; set values as you would normally do in config.g

if !exists(global.bedCenterX)                           ;; calculate bed center, insert into object model
    global bedCenterX = floor(move.axes[0].max / 2)
if !exists(global.bedCenterY)
    global bedCenterY = floor(move.axes[1].max / 2)

;=== configuration - axis - lead screw position ===;
M671 X-4.5:150:304.5 Y-4.52:305:-4.52 S5

;=== cali-flower compensation ===;
M556 S100 X0.181
M92 X80.16 Y80.13

;=== configuration - sensor - bed heater & thermistor  ===;
M308 S0 P"0.temp0" Y"thermistor" T100000 B3950 A"Bed"     ;; create sensor S0 on duet.temp0 named "Bed"
M950 H0 C"0.out0" T0 Q11                                  ;; create heater (H0) for bed
M307 H0 B0 S1.00                                          ;; on bed H0 disable bang-bang mode and set PWM limit
M140 H0                                                   ;; map heated bed to heater 0 (H0)
M143 H0 S120                                              ;; set heater H0 temperature limit to 120C

;=== !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ===;
;; run bed PID tune using code below
;;; ;;; H0 = heater 0, or bed
;;; ;;; S = temperature in C (90C)
;;; ; M303 H0 S90
;;;
;;; replace M307 below with results from M303
;;; M307 may have a Vnnn included with it
;;;  if you're using mains (AC) bed heater on your bed, omit it
;=== !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ===;
M307 H0 R0.474 K0.219:0.000 D2.07 E1.35 S1.00 B0

;=== configuration - sensor - accelerometer ===;
M955 P20.0 I10                                            ;; create accelerometer on SHT36MAX3

;;; I = accelerometer orientation, expressed as 2-digit number. see
;;;  https://www.dropbox.com/s/hu2w5mk57l4zqpg/Accelerometer%20Orientation.pdf
;;;  for all possible permutations

;=== configuration - sensor - chamber monitoring ===;
M308 S5 P"0.spi.cs1" Y"bme280" A"Chamber"
M308 S10 P"S5.2" Y"bme-humidity" A"Humidity[%]"
M308 S8 P"S5.1" Y"bme-pressure" A"Pressure[hPa]"

M308 S11 Y"mcu-temp" A"MCU"                                                   ;; MCU temperature, with offset
M912 P0 S-1.2

;=== configuration - LEDs, chamber & toolhead ===;
M950 P0 C"0.out1" Q2500                                                       ;; configure Dayspring LEDs P0 on duet.out1 (0.out1)

;=== configuration - overrides ===;
;M501                                                                         ;; config-override.g should remain empty

;=== configuration - tool - fan ===;
M950 F1 C"0.out2" Q2500
M106 P1 C"4028" S0 H-1

;=== configuration - hotend - thermistor ===;
M308 S1 P"20.max31865cs" Y"rtd-max31865" A"rapido2HF" F60 R430 W2
M950 H1 C"20.out0" T1                                                         ;; create heater output (H1) on SHT36MAX3.out0 (20.out0) and map to sensor 1 (T1)
M307 H1 B0 S1.00                                                              ;; set PWM limit (S1.00)
M563 P0 S"orbiter2.5" D0 H1 F1                                                ;; define tool0 (T0)
                                                                              ;; assign fan F1, extruder drive D0 (E0) and heater H1 to tool T0 named "orbiter2.5"
G10 P0 X0 Y0 Z0                                                               ;; set axis offsets, max temperature, initial temperature
M143 H1 S290
G10 P0 R0 S0

;=== !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ===;
;; run hotend PID tune!! using code below
;;; T0 = PID tune tool0
;;; S210 = temperature in C (210C)
;;; F0.45 = Fan PWM value; 0.45 = 45%
;;; ; M303 T0 S240 F0.45
;;; replace M307 below with results from M303
;=== !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ===;
M307 H1 R8.197 K0.917:0.692 D0.89 E1.35 S1.00 B0 V0.0           ;; rapido2uhf, new-style pt1000, max31865

;=== configuration - hotend - fan ===;
M950 F0 C"20.out2" Q250                                                           ;; create fan 0 (F0) on pin RRF.out2 (20.out2)
M106 P0 C"toolhead" S0 H1 T45 L255                                                 ;; set fan 0 (P0) to thermostatic control (45C), full-speed (L255) named "tool"

;=== configuration - extruder ===;
M569 P20.0 S1 D2                                                              ;; Extruder, RRF36.driver0
                                                                              ;; VZ-Hextrudort Low with LDO motor
M906 E1200                                                                    ;; set extruder motor current
M350 E16 I1                                                                   ;; set microstepping to 16 with interpolation
M92 E670.52
M203 E7200                                                                    ;; set max speed, jerk, acceleration
M205 E5.0
M566 E300
M201 E3000

;=== configuration - scanning z-probe ===;
M558 K1 P11 C"20.i2c.ldc1612" F12000:6000 T18000 A20
M308 A"SZP" S4 Y"thermistor" P"20.temp1" T100000 B4092                        ;; thermistor on PCB/coil
M98 P"0:/macros/config/configSZPnormal.g"                                               ;; we're using SZP touch mode

G31 K0 X-27.8 Y-12.0 Z0.80
G31 K1 X0.0 Y15.00

;=== configuration - options ===;
M955 P20.0 I12                                                                ;; accelerometer on RRF36
M950 E0 C"20.rgbled" T2 U2 Q3000000                                           ;; configure toolhead LED E0 on SHT36MAX3.rgbled (20.rgbled)

M98 P"0:/macros/config/configInputShaping.g"                                            ;; input shaping parameters
;M98 P"0:/macros/config/configFilamentMonitor.g"                                        ;; filament monitor

M950 S1 C"0.io1.out"                                                          ;; set up 0.out6 as servo S1 - nozzle wiper
M98 P"0:/macros/option/SERVO_WIPE_DISENGAGE.g"                                ;; ensure wiper is off the bed


M568 P0 R0 S0 A0                                                              ;; turn tool0 heater off
M140 S-273.1                                                                  ;; turn bed off
T0 P0                                                                         ;; select T0, don't run any toolchange macros
M703                                                                          ;; load filament specific gcode
                                                                              ;; I keep filament-specific PID tuning, retraction, and pressure advance
                                                                              ;; settings here.

;=== configuration - housekeeping ===;
M98 P"0:/macros/config/configInitPost.g"                                    ;; set the last few variables we need that rely on loaded configuration
M98 P"0:/macros/config/configBuildPlate.g"                             ;; see setBuildPlate.g for Z probe trigger value (not SZP), offset, trigger height and mesh fade.
;=== discard if necessary ===;

;=== configuration end ===;
