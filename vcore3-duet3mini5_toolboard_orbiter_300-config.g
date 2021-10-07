; config.g by omtek 
;; initial commit - 06 October 2021
;; increment this by one when you remember - changes: 6

; current configuration ;
; duet 3 mini 5+
; duet toolboard 1lc
; paneldue 7i

; Display initial welcome message
;M291 P"Please go to <a href=""https://www.duet3d.com/StartHere"" target=""_blank"">this</a> page for further instructions on how to set it up." R"Welcome to your new Duet 3!" S1 T0

; Enable network - we're using an SBC so this is commented out

;if {network.interfaces[0].type = "ethernet"}
;    M552 P0.0.0.0 S1
;else
;    M552 S1
	
; configuration - initial networking setup
;; we want HTTP (web interface); we don't need FTP or telnet
M586 P0 S1                                                                  ; enable HTTP
M586 P1 S0                                                                  ; disable FTP
M586 P2 S0                                                                  ; disable Telnet
G4 S1                                                                       ; wait for expansion boards to start (S1 = 1s delay)

;configuration - printer
;; here we tell the duet board a little about our printer
G90                                                                         ; we're sending absolute coordinates...
M83                                                                         ;  ...and relative extruder moves
                                                                            ;  be sure this is changed in your slicer

M550 P"legionXY"                                                            ; set printer name
                                                                            ;  if you're in standalone mode, this can be anything 
                                                                            ;  if you're using an SBC the name of the printer 
                                                                            ;  and the SBC hostname need to match

M669 K1                                                                     ; The Rat Rig V-Core 3 is a CoreXY printer

; configuration - motors
;; here we assign drives to axes; X-, Y- and Z1-3 are mapped here
;; extruder is on toolboard 1lc

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;;; Z-axis motors, wired to driver0,driver1,driver2
M569 P0.0 S0 D3                                                             ; physical drive 0.0 (Z-Axis) goes backwards
M569 P0.1 S0 D3                                                             ; physical drive 0.1 (Z-Axis) goes backwards
M569 P0.2 S0 D3                                                             ; physical drive 0.2 (Z-Axis) goes backwards
                                                                            ;  default is forwards; change wiring order to remedy
																			
;;; Left and right motors (X- and Y- axis, wired to driver3,driver4)
M569 P0.3 S1 D3                                                             ; physical drive 0.3 (X-Axis) goes forwards
M569 P0.4 S1 D3                                                             ; physical drive 0.4 (Y-Axis) goes forwards

;;; Extruder (E-axis), normally wired to driver5 (mini expansion) 
;M569 P0.5 S1 D3
;;; currently wired to toolboard 1lc on 121.0                               ; physical drive 0.5 (E-Axis) goes forwards
M569 P121.0 S0 D3                                                           ; physical drive 0.5 (Toolboard1LC E-Axis) goes backwards
																			                                      ;  i don't know why

; configuration - motors - axis mapping
M584 X0.3 Y0.4 Z0.0:0.1:0.2 E121.0                                          ; set axis/drive mapping
																			                                      ;  we map E-axis here despite defining extruder elsewhere
																			                                      ;  as toolboard 1lc will be connected
																			
; configuration - motors - microstepping
M350 X16 Y16 Z16 I1                                                         ; configure microstepping with interpolation

; configuration - motor travel (steps/mm, current, idle timeout)
M92 X80.00 Y80.00 Z800.00                                                   ; set steps/mm
M906 X1000 Y1000 Z800 I30                                                   ; set motor currents (in mA) and motor idle factor in percent (I30 = 30%)
																			                                      ;  will always be at least 100mA
M84 S30                                                                     ; Set idle timeout (S30 = 30s)

; configuration - motor max speed, acceeleration
M566 X400.00 Y400.00 Z6.00 P1                                               ; set maximum instantaneous speed changes (mm/min)
M203 X10800.00 Y10800.00 Z1000.00                                           ; set maximum speeds (mm/min)
M201 X3000.00 Y3000.00 Z100.00                                              ; set accelerations (mm/s^2)


; configuration - axis min/max; 300mm^3
M208 X0 Y0 Z0 S1                                                            ; set axis minima
M208 X310 Y300 Z300 S0                                                      ; set axis maxima

; configuration - endstop pins

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

M574 X1 S1 P"0.io3.in"                                                      ; configure X endstop at X- (X1)
M574 Y2 S1 P"0.io2.in"                                                      ; configure Y endstop at Y+ (Y2)
M574 Z1 S2                                                                  ; configure Z-probe endstop for low end on Z

; configuration - sensorless homing
;M574 X1 Y1 S3                                                              ; configure X- and Y- endstops for sensorless homing
;M915 X Y R0 F0                                                             ; configure motor stall detection
;M574 Z1 S2                                                                 ; configure Z-probe endstop for low end on Z


; configuration - bed leveling // lead screw position
M671 X-4.5:150:304.5 Y-4.52:305:-4.52 S5                                    ; define positions of Z leadscrews
																			                                      ;  maximum correction allowed for each leadscrew in mm (S5)
M557 X20:280 Y20:280 P5                                                     ; define 5x5 mesh grid
																			                                      ;  probe point spacing (P5)

; configuration - extruder and bed heaters/thermistors

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; configuration - bed thermistor, PID tuning
M308 S0 P"0.temp0" Y"thermistor" T100000 B3950 A"Bed"                       ; configure sensor 0 (S0) as thermistor 
                                                                            ;  on pin temp0 (0.temp0)
M950 H0 C"0.out0" T0                                                        ; create bed heater (H0) output on 
                                                                            ;  out0 (0.out0) and map it to sensor 0
M307 H0 B0 S1.00                                                            ; disable bang-bang mode (B0) for the bed 
                                                                            ;  heater (H0) and set PWM limit (S1.00)
M140 H0                                                                     ; map heated bed to heater 0 (H0)
M143 H0 S110                                                                ; set temperature limit for 
                                                                            ;  heater 0 (H0) to 110C

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;; Run Bed PID Tune!! Using code below                                                              ;;
;; M303 H0 S90								    ; run pid auto-tune     ;;
;;                                                                          ; routine on bed at 90C ;;
;; replace M307 below with results from M303                                                        ;;
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
M307 H0 B0 R0.487 C383.6 D2.05 S1.00					    ; this is my M307
									    ;  find your own
																			
;;; duet may complain that heater 0 (H0) may reach unsafe temperature
;;; this should be ok to ignore as we limit bed temp with M143 above
;;; as always do not print unattended

; configuration - hotend and part fan

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

M950 F0 C"121.out2" Q250                                                    ; create fan 0 (F0) on pin toolboard.out2 (121.out2) and set frequency (Q250)
M106 P0 C"Hotend Fan" S0 H1 T45 L255                                        ; set fan 0 name and value. thermostatic control turned on for Hotend (T45 = 45C)
M950 F1 C"121.out1" Q250                                                    ; create fan 1 (F1) on pin toolboard.out1 (121.out1) and set frequency (Q250)
M106 P1 C"Layer Fan" S0 H-1                                                 ; set fan 1 name and value. thermostatic control is turned off

; configuration - tool0
M563 P0 D0 H1 F1                                                            ; define tool 0
G10 P0 X0 Y0 Z0                                                             ; set tool 0 axis offsets
G10 P0 R0 S0                                                                ; set initial tool 0 active and standby temperatures to 0C

M950 H1 C"121.out0" T1                                                      ; create nozzle heater output (H1) on toolboard.out0 (121.out0) and map it to sensor 1 (T1)
M307 H1 B0 S1.00                                                            ; disable bang-bang mode (B0) for extruder
																			                                      ;  and set PWM limit (S1.00)
M143 H1 S280                                                                ; set the maximum temperature in C for heater (S280 = 280C)

; configuration - extruder
;; LDO Orbiter v1.5 LDO-36STH20-1004AHG
;; we define E-axis seperately here to make future extruder changes easier.
;; different values for M203, M201, M207 etc are for different Orbiter motors

M350 E16 I1								    ; microstepping set to 16 (E16) with interpolation (I1)
M92 E690                                                        	    ; set extruder steps per mm, 0.9 angle/step
                                                                    	    ;  (LDO-36STH20-1004AHG with Orbiter v1.5)
M203 E7200.00                                                       	    ; max speed mm/min (E3600 or E7200)
M566 E300                                                             	    ; instantaneous speed change mm/min
M201 E800                                                             	    ; acceleration mm/s^2 (E600 or E800)
M906 E1200 I10                                                         	    ; set extruder motor current (E500 or E1200, in mA)   
                                                                       	    ;  and idle factor in per cent (I10 = 10%) 
M207 S1.5 F7200 Z0.2                                                   	    ; firmware retraction (S1.5 = length in mm, feed F3600 or F7200, z-hop Z0.2)

; configuration - extruder thermistor
M308 S1 P"121.temp0" Y"thermistor" T100000 B4725 C7.060000e-8 A"Hotend"     ; configure sensor 1 (S1) as thermistor 
                                                                            ;  on pin toolboard.temp0 (121.temp0)
									    
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;; Run hotend PID Tune!! Using code below                                                           ;;
;; M303 H1 S240								    ; run pid auto-tune     ;;
;;                                                                          ; routine on hotend     ;;
;;                                                                          ; at 240C               ;;
;; replace M307 below with results from M303                                                        ;;
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;

M307 H1 B0 R1.620 C183.6 D7.36 S1.00 V24.0				    ; this is my M307
						   		       	    ;  find your own
; configuration - z-probe

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; Inductive Probe (ezabl, pinda, superpinda, euclid)
; M558 P5 C"!io3.in" H5 F400 T5000					    ; set Z probe type to unmodulated and the dive height + speeds
; G31 P500 X-27.8 Y-12 Z0.20						    ; set Z probe trigger value, offset and trigger height, more Z means closer to the bed

;; BLTouch
M950 S0 C"121.io0.out"                                          	    ; Create a servo pin (S0) on toolboard.io0.out (121.io0.out)
M558 P9 C"121.io0.in" H5 F100 T2000 A5                                	    ; set Z probe type to BLTouch (P9) and the 
                                                                    	    ;  dive height (H5) + speeds (F100) and input 
                                                                       	    ;  to toolboard.io0.in (121.io0.in)
G31 P25 X-28.00 Y-13.00 Z0.90                                         	    ; set Z probe trigger value (P25) 
                                                                       	    ;  offset (X-28.00,Y-13.00) and 
									    ;  more Z means closer to the bed

; configuration - pressure advance
M404 N1.75 D0.4                                                             ; Filament width (N1.75mm) and nozzle diameter (D0.4mm)
T0                                                                          ; select tool0
M572 D0 S0.10
