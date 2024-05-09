; config.g by omtek 
;; initial commit - 06 October 2021
;; rewrite - 08 October 2021

; current configuration ;
; duet 3 mini 5+ running RRF 3.3 with raspberry pi 4B+ 4GB
; duet toolboard 1lc
; paneldue 7i
; ldo orbiter v1.5 with LDO-36STH20-1004AHG

; dragon sf hotend

;====;
; begin config.g ;

; Display initial welcome message ; this is the default welcome message included with the image.  
;  comment the line below to no longer display

;M291 P"Please go to <a href=""https://www.duet3d.com/StartHere"" target=""_blank"">this</a> page for further instructions on how to set it up." R"Welcome to your new Duet 3!" S1 T0

; enable network ;
;  we're using an SBC so this is commented out

;if {network.interfaces[0].type = "ethernet"}
;    M552 P0.0.0.0 S1
;else
;    M552 S1
	
; configuration - initial networking setup ;
;; we want http (web interface); we don't need ftp or telnet
;; enable http
;;; P = protocol, 
;;; S =  0 - disable, 1 - enable
M586 P0 S1
;; disable ftp                                                                  
M586 P1 S0
;; disable telnet                                                                  
M586 P2 S0
;; wait for expansion boards (toolboard 1lc, tool distribution board etc) to start 
;;; S1 = 1s delay                                                                  
G4 S1                                                                       

; PanelDue init ;
;; initialize the PanelDue 
;;; P1 = on serial port 1 
;;; S1 = PanelDue mode /w checkum req'd 
;;; B115200 = baud 115200
M575 P1 S1 B115200

; configuration - printer ;
;; here we tell the duet board a little about our printer
;;; we're sending absolute coordinates...
G90
;;;  ...and relative extruder moves 
;;;   be sure this is changed in your slicer                                                                        
M83
;; set the printer name
;;  if you're in standalone mode, this can be anything 
;;  if you're using an SBC the name of the printer 
;;   and the SBC hostname need to match
M550 P"legionXY"                                                            
;; The Rat Rig V-Core 3 is a CoreXY printer
;;; Kinematics type: 1 = CoreXY
M669 K1                                                                     

; configuration - motors ;

;; here we assign drives to axes; X-, Y- and Z1-3 are mapped here
;; extruder is on toolboard 1lc

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; Z-axis motors, wired to driver0,driver1,driver2
;; physical drive 0.0,0.1,0.2 (Z-Axis) goes forwards (S1)
;;  we're using spreadcycle mode (D2) as stealthchop would stall after idle timeout
;;  this can be remedied by tuning stepper drivers here and movement/accel numbers below
M569 P0.0 S1 D2                                                             
M569 P0.1 S1 D2
M569 P0.2 S1 D2
;; Left and right motors (X- and Y- axis, wired to driver3,driver4)
;;; physical drive 0.3 (X-Axis) goes backwards (S0)
M569 P0.3 S0 D2
;;; physical drive 0.4 (Y-Axis) goes backwards (S0)
M569 P0.4 S0 D2
;; Extruder (E-axis), normally wired to driver5 (mini expansion) 
;; M569 P0.5 S1 D3 ;; old gcode ;;
;; currently wired to toolboard 1lc on 121.0
;;; physical drive 121.0 (E-Axis) goes forwards (S1), 
;;; D3 =  stealthchop on the toolboard 1lc                             
M569 P121.0 S1 D2

; configuration - motors - axis mapping ;
;; set axis/drive mapping
;;  we map E-axis here despite defining extruder lower
;;  as toolboard 1lc will be connected
M584 X0.3 Y0.4 Z0.0:0.1:0.2 E121.0

; configuration - motors - microstepping ;
;; configure microstepping
;;; I1 = interpolation enabled
M350 X16 Y16 Z16 I1                                                         

; configuration - motor travel (steps/mm, current, idle timeout) ;
;; set steps/mm
M92 X80.00 Y80.00 Z800.00
;; set motor currents (in mA) 
;;  will always be at least 100mA
;;; I30 = motor idle factor in percent (30%)                                                 
M906 X1500 Y1500 Z1000 I30                                                   
;; Set idle timeout
;;;  S30 = 30s																		                                      
M84 S30                                                                     

; configuration - motor max speed, acceeleration ;
;; set maximum instantaneous speed changes (mm/min)
;;; P1 =  jerk policy; allows jerk to be applied between any pair of moves 
M566 X400.00 Y400.00 Z6.00 P1 
;; set maximum speeds (mm/min)                                              
M203 X10800.00 Y10800.00 Z1000.00 
;; set accelerations (mm/s^2)                                          
M201 X3000.00 Y3000.00 Z100.00                                              

; configuration - axis min/max ;
;;  our printer is 300mm^3 volume 
;;; S1 = set axis minimum
M208 X0 Y0 Z0 S1
;;; S0 = set axis maximum                                                           
M208 X310 Y300 Z300 S0                                                      

; configuration - endstop pins ;

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; our left- and right- axis endstops are connected to duet. inputs
;; to eliminate CAN bus latency during homing moves
;; and allow future installation of filament sensor
;;; configure active high (S1) X endstop at X- (X1) on duet.io3.in (0.io3.in)
M574 X1 S1 P"0.io3.in"   
;;; configure Y active high (S1) endstop at Y+ (Y2) on duet.io2.in (0.io2.in)                                                   
M574 Y2 S1 P"0.io2.in"   
;;; configure Z-probe (S2) endstop at low end (Z1)                                                 
M574 Z1 S2                                                                  

; configuration - sensorless homing ; 
;; could not get this working
;; leaving in to come back to
;M574 X1 Y1 S3                                                              ; configure X- and Y- endstops for sensorless homing
;M915 X Y R0 F0                                                             ; configure motor stall detection
;M574 Z1 S2                                                                 ; configure Z-probe endstop for low end on Z

; configuration - bed leveling // lead screw position ;
;; define positions of Z leadscrews
;;; S5 = maximum correction allowed for each leadscrew in mm
M671 X-4.5:150:304.5 Y-4.52:305:-4.52 S5
;; define 5x5 mesh grid with point spacing (P5)                                   
M557 X20:280 Y20:280 P5                                                     
																			                                      
; configuration - extruder and bed heaters/thermistors ;

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; configuration - bed thermistor, PID tuning
;;; configure sensor 0 (S0) on  
;;; pin duet.temp0 (0.temp0) as thermistor on (Y) 
;;; T = thermistor resistance at 25°C
;;; B = beta value
;;; A = named bed
M308 S0 P"0.temp0" Y"thermistor" T100000 B3950 A"bed"
;;; create heater output (H0) for bed
;;; on duet.out0 (0.out0) and 
;;; map to sensor 10 (T0)
M950 H0 C"0.out0" T0
;;; on bed (H0)
;;; B0 = disable bang-bang mode   
;;; and set PWM limit (S1.00)                                                  
M307 H0 B0 S1.00
;;; map heated bed to heater 0 (H0)                                                            
M140 H0
;;; set temperature limit for 
;;;  heater 0 (H0) to 110C
M143 H0 S110

;;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;;; run bed PID tune!! using code below 
;;; ;; run pid auto-tune routine on bed
;;; ;;; H0 = heater 0, or bed
;;; ;;; S = temperature in C (90C)
;;; ; M303 H0 S90
;;;
;;; replace M307 below with results from M303
;;; M307 will have a Vnnn included with it
;;;  if you're using a mains (AC) bed heater on your bed, omit it
;;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;;; this is my M307, find your own
M307 H0 B0 R0.487 C383.6 D2.05 S1.00

;;; duet may complain that heater 0 (H0) may reach unsafe temperature
;;; this should be ok to ignore as we limit bed temp with M143 above
;;; as always do not print unattended

; configuration - hotend and part fan ;

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;;; create fan 0 (F0) 
;;; on pin toolboard.out2 (121.out2) 
;;; Q = set PWM frequency in Hz. valid range: 0-65535
;;;  default: 500 for GpOut pins, 250 for fans and heaters   
M950 F0 C"121.out2" Q250 
;;; set fan 0 (P0) to
;;; C = custom name hotend fan
;;; S = fan speed, initial value
;;; H = thermostatic control turned on for hotend fan
;;; T = trigger temperature in celcius; integer or range (T45= 45C) 
;;; L = minimum fan speed (L255 = full speed)                                                  
M106 P0 C"hotend fan" S0 H1 T45 L255   
;;; create fan 1 (F1) on pin toolboard.out1 (121.out1)
;;; Q = set PWM frequency in Hz. valid range: 0-65535
;;;  default: 500 for GpOut pins, 250 for fans and heaters                                   
M950 F1 C"121.out1" Q250  
;;; set fan 1 (P1)
;;; C = custom name to layer fan 
;;; S = fan speed, initial value
;;; H = thermostatic control is turned off (H-1)        
M106 P1 C"layer fan" S0 H-1                                                 

; configuration - tool0

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; define tool 0
;; here we assign fans, extruder drives, heaters to a tool definition
;;; P = tool number (P0 = first tool)
;;; S"name" =  tool name (optional)
;;; D =  extruder drive
;;;  we have a single extruder defined above hence (D0)
;;; H = heater H1 is defined above
;;; F = fan(s) to map fan 1
M563 P0 S"dragonSF" D0 H1 F1 
;; set tool 0 axis offsets 
;;; P = tool number                                                           
G10 P0 X0 Y0 Z0  
;; set initial tool 0 (P0) temperatures
;;; R = standby temperatures in C    
;;; S = active temperature in C                                                      
G10 P0 R0 S0  
;;; create heater output (H1) for hotend
;;; on toolboard.out0 (121.out0) and 
;;; map to sensor 1 (T1)
M950 H1 C"121.out0" T1 
;;; on hotend (H1)
;;; B0 = disable bang-bang mode   
;;; and set PWM limit (S1.00)                                                  
M307 H1 B0 S1.00                                                           
;; set the maximum temperature in C for 
;;; H = heater 1, or hotend 
;;; S = max temperature (280C)																			                                     
M143 H1 S280     

;; configuration - hotend thermistor
;;; configure sensor 1 (S1) on 
;;; pin toolboard.temp0 (121.temp0) as thermistor (Y) 
;;; T = thermistor resistance at 25°C
;;; B = beta value
;;; C = steinhart-hart c coefficient
;;; A = named hotend
M308 S1 P"121.temp0" Y"thermistor" T100000 B4725 C7.060000e-8 A"hotend"   

;;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;;; run hotend PID tune!! using code below 
;;; ;; run pid auto-tune routine on hotend
;;; ;;; H1 = heater 1, or hotend
;;; ;;; S = temperature in C (240C)
;;; ; M303 H1 S240
;;;
;;; replace M307 below with results from M303
;;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;;; this is my M307 find your own									    
M307 H1 B0 R1.620 C183.6 D7.36 S1.00 V24.0

; configuration - extruder
;; LDO Orbiter v1.5 LDO-36STH20-1004AHG
;; we define E-axis seperately here to make future extruder changes easier.
;; different values for M203, M201, M207 etc are for different Orbiter motors
;;; E = microstepping set to 16 
;;; I = interpolation
M350 E16 I1		
;;; set extruder steps per mm, 0.9 angle/step
;;;  (LDO-36STH20-1004AHG with Orbiter v1.5)														    
M92 E690	
;;; max speed mm/min (E3600 or E7200)                                                       	    
M203 E3600.00  
;;; instantaneous speed change mm/min                                                     	    
M566 E300  
;;; acceleration mm/s^2 (E600 or E800)                                                          	    
M201 E600  
;;; set extruder motor current (E500 or E1200, in mA)   
;;;  and idle factor in per cent (I10 = 10%)                                                           	    
M906 E500 I10                                                         	    
;; firmware retraction settings
;;; S1.5 = length in mm, feed F3600 or F7200,  
;;; Z = z-hop
;;;  consider moving this to filament gcode, if possible                                                                      	     
M207 S1.5 F7200 Z0.2                                                   	   


; configuration - z-probe ;

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; Inductive Probe (ezabl, pinda, superpinda, euclid)
; set Z probe type to unmodulated and the dive height + speeds
; M558 P5 C"!io3.in" H5 F400 T5000		
; set Z probe trigger value, offset and trigger height, more Z means closer to the bed			    
; G31 P500 X-27.8 Y-12 Z0.20						    

;; BLTouch connected to toolboard.io0
;;; Create a servo pin (S0) on toolboard.io0.out (121.io0.out)
M950 S0 C"121.io0.out"  
;;; set Z probe type to BLTouch (P9)
;;;  on toolboard.io0.in (121.io0.in)                                        	    
;;;  H5 = dive height 
;;;  speed (F100) and travel (T2000) 
;;;  A5 = probe point max 
M558 P9 C"121.io0.in" H5 F100 T2000 A5    
;;; P25 = set Z probe trigger value
;;;  offset (X-28.00,Y-13.00) 
;;; Z2.00 = trigger height
;;;  more Z means closer to the bed                            	    
G31 P25 X-28.00 Y-13.00 Z2.10                                         	    

; configuration - pressure advance
;;; N1.75 = filament width (mm)
;;; D0.4 = nozzle diameter (mm)
M404 N1.75 D0.4  
;; select tool0                                                           
T0
;;; set extruder pressure advance amount on tool 0 (D0) to (S0.10)                                                                         
M572 D0 S0.10