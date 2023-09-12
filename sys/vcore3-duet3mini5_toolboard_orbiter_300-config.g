;; sacrifical colons. delete or add semicolons to this line and save
;if you're too lazy to type M999
; config.g by omtek

; current configuration ;
; duet 3 mini 5+ running RRF 3.3 with raspberry pi 4B+ 4GB
; duet toolboard 1lc
; paneldue 7i
; ldo orbiter v2,0 with LDO-36STH20-1004AHG
; e3d revo voron hotend

;====;
; begin config.g ;

;if (state.atxPower!=true) ; if this is a cold start, we leave the ATX switch off.  Otherwise leave as is.
;	M81 C"pson" ; define the pson pin as power control and set to off by default

; Global variable to run/not run daemon.g - checked in daemon.g and abort if false
if !exists(global.RunDaemon)
	global RunDaemon = false  
else
	set global.RunDaemon = true 

; Global variable to run/not run heater checks daemon.g - checked in daemon.g and abort if false
if !exists(global.RunHeaterChecks)
	global RunHeaterChecks = true  
else
	set global.RunHeaterChecks = true

if !exists(global.Cancelled)  ; global variable for exiting out of loops
	global Cancelled = false  
else
	set global.Cancelled = false 

if !exists(global.filamentDistance)
	global filamentDistance = 0 ; global for use to allow filament to feed for set distance after sensor trips 
else
	set global.filamentDistance = 0

if !exists(global.filamentFeedSpeed)
	global filamentFeedSpeed = 180 ; global to set the feed speed used in filament changes - adjusted per filament in filament config.c 
else
	set global.filamentFeedSpeed = 180

if !exists(global.filamentRetractSpeed)
	global filamentRetractSpeed = 1800 ; global to set the retract speed used in filament changes - adjusted per filament in filament config.c 
else
	set global.filamentRetractSpeed = 1800
	
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
;;; D2 =  spreadcycle on the toolboard 1lc                             
M569 P121.0 S0 D2

; configuration - motors - axis mapping ;
;; set axis/drive mapping
;;  we map E-axis here despite defining extruder lower
;;  as toolboard 1lc will be connected
M584 X0.3 Y0.4 Z0.0:0.1:0.2 E121.0

; configuration - motors - microstepping ;
;; configure microstepping
;;; I1 = interpolation enabled
M350 X16 Y16 Z16 I1                                                         
;M350 X64 Y64 Z64 I0                                                         

; configuration - motor travel (steps/mm, current, idle timeout) ;
;; set steps/mm
M92 X80.00 Y80.00 Z800.00
;; set motor currents (in mA) 
;;  will always be at least 100mA
;;; I30 = motor idle factor in percent (30%)                                                 
M906 X1600 Y1600 Z1600 I30                                                   
;; Set idle timeout
;;;  S30 = 30s																		                                      
M84 S30                                                                     

; configuration - motor max speed, acceeleration ;
;; we're loading off a macro now
;; set all the max speeds in macro as these are adjusted during home moves so we only want to adjust in one spot
M98 P"0:/sys/set_max_speeds.g" 

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
;M574 X1 S1 P"0.io3.in"   
M574 X1 S1 P"121.io2.in"   
;;; configure Y active high (S1) endstop at Y+ (Y2) on duet.io2.in (0.io2.in)                                                   
M574 Y2 S1 P"0.io2.in"   
;;; configure Z-probe (S2) endstop at low end (Z1)                                                 
M574 Z1 S2                                                                  

; configuration - bed leveling // lead screw position ;
;; define positions of Z leadscrews
;;; S5 = maximum correction allowed for each leadscrew in mm
M671 X-4.5:150:304.5 Y-4.52:305:-4.52 S5
																			                                      
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
M950 H0 C"0.out0" T0 Q11
;;; on bed (H0)
;;; B0 = disable bang-bang mode   
;;; and set PWM limit (S1.00)                                                  
M307 H0 B0 S1.00
;;; map heated bed to heater 0 (H0)                                                            
M140 H0
;;; set temperature limit for 
;;;  heater 0 (H0) to 110C
M143 H0 S120

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
;M307 H0 R0.481 K0.479:0.000 D1.84 E1.35 S1.00 B0
M307 H0 R0.492 K0.279:0.000 D2.01 E1.35 S1.00 B0

;;; duet may complain that heater 0 (H0) may reach unsafe temperature
;;; this should be ok to ignore as we limit bed temp with M143 above
;;; as always do not print unattended

; configuration - part fan ;

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;;; create fan 1 (F1) on pin toolboard.out1 (121.out1)
;;; Q = set PWM frequency in Hz. valid range: 0-65535
;;;  default: 500 for GpOut pins, 250 for fans and heaters                                   
;;; set fan 1 (P1)
;;; C = custom name to layer fan 
;;; S = fan speed, initial value
;;; H = thermostatic control is turned off (H-1)        
M950 F1 C"!0.out4+0.out4.tach"
M106 P1 C"Part Fan" S0 H-1                                                 

; configuration - tool0

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; define tool 0
;; configuration - hotend thermistor
;;; configure sensor 1 (S1) on 
;;; pin toolboard.temp0 (121.temp0) as thermistor (Y) 
;;; T = thermistor resistance at 25°C
;;; B = beta value
;;; C = steinhart-hart c coefficient
;;; A = named hotend
M308 S1 P"121.temp0" Y"thermistor" T100000 B4725 C7.060000e-8 A"hotend"   


;;; create heater output (H1) for hotend
;;; on toolboard.out0 (121.out0) and 
;;; map to sensor 1 (T1)
M950 H1 C"121.out0" T1 
;;; on hotend (H1)
;;; B0 = disable bang-bang mode   
;;; and set PWM limit (S1.00)                                                  
M307 H1 B0 S1.00       
;; here we assign fans, extruder drives, heaters to a tool definition
;;; P = tool number (P0 = first tool)
;;; S"name" =  tool name (optional)
;;; D =  extruder drive
;;;  we have a single extruder defined above hence (D0)
;;; H = heater H1 is defined above
;;; F = fan(s) to map fan 1
M563 P0 S"revo" D0 H1 F1 
;; set tool 0 axis offsets 
;;; P = tool number                                                           
G10 P0 X0 Y0 Z0  
;; set initial tool 0 (P0) temperatures
;;; R = standby temperatures in C    
;;; S = active temperature in C                                                      
G10 P0 R0 S0  
;; set the maximum temperature in C for 
;;; H = heater 1, or hotend 
;;; S = max temperature (280C)																			                                     
M143 H1 S280     

;;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;;; run hotend PID tune!! using code below 
;;; ;; run pid auto-tune routine on hotend
;;; ;;; H1 = heater 1, or hotend
;;; ;;; S = temperature in C (240C)
;;; ;;; F = Fan PWM value, 1.0 = 100%
;;; ; M303 H1 S240
;;;
;;; replace M307 below with results from M303
;;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;;; this is my new M307, using 4028 fans, E3D Revo hotend, 0.4mm brass nozzle
M307 H1 R2.788 K0.501:0.000 D6.52 E1.35 S1.00 B0 V24.0

; configure hotend fan
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
M106 P0 C"Tool Fan" S0 H1 T45 L255   

; configuration - extruder
;; LDO Orbiter v2.0
;; we define E-axis seperately here to make future extruder changes easier.
;; different values for M203, M201, M207 etc are for different Orbiter motors
;;; E = microstepping set to 16 
;;; I = interpolation
M350 E16 I1		
;;; set extruder steps per mm, 0.9 angle/step
;;;  (LDO-36STH20-1004AHG with Orbiter v1.5)														    
;M92 E690	
;; orbiter v2.0
;M92 E673.06
;; Vz-HextrudORT
M92 E900
;;; max speed mm/min (E3600 or E7200)                                                       	    
M203 E7200  
;;; instantaneous speed change mm/min                                                     	    
M566 E300  
;;; acceleration mm/s^2 (E600 or E800)                                                          	    
M201 E10000  
;;; set extruder motor current (E500 or E1200, in mA)   
;;;  and idle factor in per cent (I10 = 10%)                                                           	    
;; orbiter v2.0
;M906 E1200 I10              
;; Vz-HextrudORT
M906 E800 I10
;; firmware retraction settings
;;; S1.5 = length in mm, feed F3600 or F7200,  
;;; Z = z-hop
;;;  moving this to filament gcode                                                                      	     
;M207 S0.2 F7200 Z0.2                                                   	   

;; filament monitors
;M98 P"0:/sys/filament_monitor.g"

; configuration - z-probe ;
;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; Inductive Probe (ezabl, pinda, superpinda, euclid)
;; SuperPINDA installed on 121.io2
; set Z probe type to unmodulated and the dive height + speeds	
;M558 P8 C"121.io2.in"  H1.5 F600:120 T12000 A20 B1		
;; klicky probe installed on 121.io1
M558 P8 C"121.io0.in" H5 F300:120 T6000 A20 B0
; set Z probe trigger value, offset and trigger height, more Z means closer to the bed			    
;G31 P500 X-30 Y-15 Z1.4
M98 P"0:/sys/build_plate.g"
;; define 10x10 mesh grid with point spacing (P10)                                   
;M557 X5:290 Y5:280 S14
M98 P"0:/sys/setDefaultProbePoints.g"

;Calculate bed centre
if !exists(global.Bed_Center_X)
	global Bed_Center_X = floor(move.axes[0].max / 2)
if !exists(global.Bed_Center_Y)
	global Bed_Center_Y = floor(move.axes[1].max  / 2)

;;; pull in config-override.g settings
M501

; configuration - accelerometer

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; accelerometer on toolboard 1lc
;;; P = set boardAddress.deviceNumber
;;; I = accelerometer orientation, expressed as 2-digit number. see 
;;;  https://www.dropbox.com/s/hu2w5mk57l4zqpg/Accelerometer%20Orientation.pdf 
;;;  for all possible permutations
;;; R = resolution, in bits. typically 8, 10 or 12
;;; C = specify CS & INT pin pair, when connecting over SPI
;;; S = sample rate, in hz.
;;;  R is ignored without S.  S without R uses default resolution.
;;;  To find current rate and resolution, send
;;;M955 P
M955 P121.0 I54 R10
;M955 P121.0 I12 R10


;; pull input_shaping.g
M98 P"0:/sys/input_shaping.g"

;setup Duet 3 Mini 5+ MCU temperature
M308 S10 Y"mcu-temp" A"MCU" ; defines sensor 10 as MCU temperature sensor
M950 F2 C"0.out5" Q100 ; create fan 2 on pin fan2 and set its frequency
M106 P2 H3 T40:70 ; set fan 2 value
;M308 S11 Y"drivers" A"Duet stepper drivers" ; defines sensor 11 as stepper driver temperature sensor

M912 P0 S-1.2 ; duet mcu temperature offset

T0 ; select tool

M568 P0 R0 S0 A0 ; turn off heater on tool zero
M140 S-273.1 ; turn off bed

; Global Variables for heater checking routine in daemon.g
;if !exists(global.HeaterCheckInterval)
;	global HeaterCheckInterval=6 ; variable for use in daemon.g sets interval of heater checks
;else
;	set global.HeaterCheckInterval=6 ; variable for use in daemon.g sets interval of heater checks
;while heat.heaters[1].current=2000 ; loop until thermistor values are stable
;	G4 P1
;	if iterations > 10000 ; if it takes more than 10 seconds we have a problem with the thermistor
;		M118 P0 L1 S"Thermistor failed to stabilize in less than 10 seconds"
;		break
;echo "sensor stable time: " ^ state.upTime ^ "." ^ state.msUpTime
;if !exists(global.LastTemp) || global.LastTemp=null
;	global LastTemp=heat.heaters[1].current ; Set variable to current extruder temp.
;else
;	set global.LastTemp=heat.heaters[1].current ; Set variable to current extruder temp.
G4 P10
;if !exists(global.LastCheckTime)
;	global LastCheckTime=0 ; variable for use in daemon.g 
;else
;	set global.LastCheckTime=0 ; variable for use in daemon.g
if !exists(global.BedPreheatTemp)
	global BedPreheatTemp=0 ; variable for use in preheating 
else
	set global.BedPreheatTemp=0 ; variable for use in preheating 
; extrusion
if !exists(global.LoadedFilament) || global.LoadedFilament=null; global variable to hold filament name
	global LoadedFilament="No_Filament" ; create a filament variable
G4 P10
if move.extruders[state.currentTool].filament=""
	echo "No filament loaded.  Cold extrude & retract set to defaults"
	M302 S190 R110 ; Allow extrusion starting from 190°C and retractions already from 110°C (defaults)
	set global.LoadedFilament="No_Filament"
else
	set global.LoadedFilament=move.extruders[state.currentTool].filament ; set the variable to the currently loaded filament
	echo "Loading config for " ^ global.LoadedFilament ^ " filament"
	M703 ; if a filament is loaded, set all the heats and speeds for it by loading config.g
G4 P10
; Custom settings
; Power failure recovery
M911 S23.2 R23.6 P"M42P5S0 M568P0A0 M913X0Y0 G91 M203 Z3600 M83 G1Z6F3600 G1E-3F3000" ; If power drops below 23.2v then turn off fans, Set X & Y current to zero, raise head, retract.
;play startup tune
M98 P"0:/macros/songs/itchyscratchy.g"								; Play tune
