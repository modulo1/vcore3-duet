 ;;;; sacrifical colons. delete or add semicolons to this line and save
;if you're too lazy to type M999
; config.g by omtek

; current configuration ;
; duet 3 mini 5+ running RRF 3.5rc3 with raspberry pi 4B+ 4GB
; Mellow Fly RRF36 Toolboard
; CannedERCF Board
; PanelDue 7i
; VZ-Hextrudort
; E3D Revo voron hotend

;=== CAN-FD Bus ===;
;; 19. CannedERCF
;; 20. SHT36MAX3 Toolboard
;; 0.  mainboard

;=== sensors referenced with M308 ===;
;; S0 = bed (0.temp0)
;; S1 = hotend (20.temp0)
;; S5 = DHT22 temperature, chamber (0.io4.out+0.io4.in)
;; S8 = DHT22 humidity, chamber (SPI)
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
;; P0 = Dayspring LEDs (0.out5)
;; F1 = 4028 part-cooling fan (0.out4+0.out4.tach)
;; F0 = tool fan (20.out2)
;; F2 = mainboard fan
;; === ERCF === ;;
;; S10 = tophat servo (19.io0.out)
;; S5 = filament cutter (0.vfd)

;=== interrupt triggers used ===;
;; T9 = trigger9.g, used for ERCF Blinky

;=== initialize variables ===;
M98 P"0:/sys/init_pre.g"                                  ;; set some variables that we need for configuration
;=== discard if necessary ===;

;=== configuration - initial networking setup ===;
M586 P0 S1                                                ;; enable http, disable ftp, disable telnet, set printer name, wait 5s for expansion boards
M586 P1 S0
M586 P2 S0
G4 S5
M550 P"legionXY"                                          ;; in SBC mode, M550 goes in dsf-config.g, not config.g
M552 S1
;G4 S5
;M122 P500 S0

;=== configuration -  PanelDue init ===;
M575 P1 S1 B57600

;=== configuration - printer ===;
G90                                                       ;; absolute coordinates, relative extruder moves
M83
M669 K1                                                   ;; Kinematics type: 1 = CoreXY

;=== configuration - drive ===;
M569 P0.0 S0 D2                                           ;; Z-axis motors, 0.driver0,0.driver1,0.driver2
M569 P0.1 S0 D2
M569 P0.5 S0 D2
M569 P0.3 S1 D2                                           ;; Left and right motors (X- and Y- axis), 0.driver3,0.driver4
M569 P0.4 S1 D2

;=== configuration - drive - axis mapping ===;
M584 X0.3 Y0.4 Z0.1:0.0:0.5 E20.0                         ;;  map E-axis here as toolboard will be connected

;=== configuration - drive - microstepping ===;
M350 X16 Y16 Z16 I1

;=== configuration - drive - steps/mm, current, idle timeout ===;
M92 X80 Y80 Z800                                          ;; set steps/mm, current (mA), idle timeout
;M92 X80.22 Y80.07 Z800                                          ;; set steps/mm, current (mA), idle timeout

;=== configuration - drive - speed, acceeleration, jerk ===;
M98 P"0:/sys/configMaxSpeed.g"                               ;; set all the max speeds below as these are adjusted during home moves so we only want to adjust in one spot

;=== configuration - axis - min/max ===;
M208 X0 Y0 Z0 S1
M208 X310 Y300 Z300 S0

;=== configuration - axis - endstops ===;
M574 X1 S1 P"20.io2.in"                                   ;; configure active high (S1) X endstop at X- (X1) on RRF36.io2.in (20.io.in)
M574 Y2 S1 P"0.io2.in"                                    ;; configure Y active high (S1) endstop at Y+ (Y2) on duet.io2.in (0.io2.in)
M574 Z1 S2                                                ;; configure Z-probe (S2) endstop at low end (Z1)

;=== configuration - axis - z-probe ===;
;M558 P8 C"^20.io0.in" H5:1 F300:120 T9000 A20 B0 K0         ;; klicky pcb probe installed on RRF36.io0.in (20.io0.in)
M558 P8 C"20.io0.in" H5:1 F300:120 T12000 A20 B0 K0         ;; inductive probe installed on RRF36.io0.in (20.io0.in)

;=== configuration - axis - mesh compensation and bed dismensions ===;
;M98 P"0:/sys/configDefaultProbePoints.g"                     ;; define mesh grid with allowance for mesh generation on printed area only
M557 X20:295 Y20:295 P20                                      ;; set values as you would normally do in config.g

if !exists(global.bedCenterX)                           ;; calculate bed center, insert into object model
    global bedCenterX = floor(move.axes[0].max / 2)
if !exists(global.bedCenterY)
    global bedCenterY = floor(move.axes[1].max  / 2)

;=== configuration - axis - lead screw position ===;
M671 X-4.5:150:304.5 Y-4.52:305:-4.52 S5

;=== cali-flower skew compensation ===;
;M556 S100 X0.22

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
;M307 H0 R0.480 K0.256:0.000 D2.03 E1.35 S1.00 B0          ;; this is my M307, find your own
M307 H0 R0.475 K0.253:0.000 D1.98 E1.35 S1.00 B0


;=== configuration - sensor - accelerometer ===;
M955 P20.0 I10                                            ;; create accelerometer on RRF36
;;; I = accelerometer orientation, expressed as 2-digit number. see
;;;  https://www.dropbox.com/s/hu2w5mk57l4zqpg/Accelerometer%20Orientation.pdf
;;;  for all possible permutations

;=== configuration - sensor - chamber monitoring ===;
M308 S5 P"0.io4.out+0.io4.in" Y"dht22" A"Chamber"         ;; DHT22 setup
M308 S8 P"S5.1" Y"dht-humidity" A"Humidity[%]"
M308 S11 Y"mcu-temp" A"MCU"                               ;; MCU temperature, with offset
M912 P0 S-1.2
M950 F2 C"0.out3" Q250                                                       ;; create fan2 (F2) on pin 0.out2
M106 P2 C"mainboard cooling" S0 H1 T155 L255                                 ;; set fan2 (P2) to thermostatic control (155C), full-speed (L255) named "mainboard cooling"
;=== configuration - LEDs, chamber & toolhead ===;
M950 P0 C"0.out5" Q1000                                   ;; configure Dayspring LEDs P0 on duet.out5 (0.out5)

;=== configuration - overrides ===;
;M501                                                     ;; config-override.g should remain empty

;=== configuration - gizmo1 ===;
M98 P"0:/sys/gizmo5.g"                                     ;; dragonHF + vz-hextrudort + MFBS superlight


M568 P0 R0 S0 A0                                          ;; turn tool0 heater off
M140 S-273.1                                              ;; turn bed off
T0 P0                                                     ;; select T0, don't run any toolchange macros
M39                                                       ;; show SD card status in console
;=== configuration ===;

;=== configuration - housekeeping ===;
M98 P"0:/sys/init_post.g"                                 ;; set the last few variables we need that rely on loaded configuration
M98 P"0:/sys/configBuildPlate.g"                             ;; see setBuildPlate.g for Z probe trigger value, offset, trigger height
;=== discard if necessary ===;
