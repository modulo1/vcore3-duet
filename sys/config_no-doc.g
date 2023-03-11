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
;; enable http
M586 P0 S1
;; disable ftp                                                                  
M586 P1 S0
;; disable telnet                                                                  
M586 P2 S0
;; wait for expansion boards (toolboard 1lc, tool distribution board etc) to start 
G4 S1                                                                       

; PanelDue init ;
M575 P1 S1 B115200

; configuration - printer ;
;; absolute coordinates...
G90
;; relative extruder  
M83
;; set the printer name
M550 P"legionXY"                                                            
;; The Rat Rig V-Core 3 is a CoreXY printer
M669 K1                                                                     

; configuration - motors ;
;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; Z-axis motors, wired to driver0,driver1,driver2
M569 P0.0 S1 D2                                                             
M569 P0.1 S1 D2
M569 P0.2 S1 D2
;; Left and right motors (X- and Y- axis, wired to driver3,driver4)
M569 P0.3 S0 D2
M569 P0.4 S0 D2
;; Extruder (E-axis), normally wired to driver5 (mini expansion) 
M569 P121.0 S0 D2

; configuration - motors - axis mapping ;
M584 X0.3 Y0.4 Z0.0:0.1:0.2 E121.0

; configuration - motors - microstepping ;
M350 X16 Y16 Z16 I1                                                         

; configuration - motor travel (steps/mm, current, idle timeout) ;
M92 X80.00 Y80.00 Z800.00
;; set motor currents (in mA) 
M906 X1600 Y1600 Z1600 I30                                                   
;; Set idle timeout
M84 S30                                                                     

; configuration - motor max speed, acceeleration ;
;; we're loading off a macro now
M98 P"0:/sys/set_max_speeds.g" 

; configuration - axis min/max ;
M208 X0 Y0 Z0 S1
M208 X310 Y300 Z300 S0                                                      

; configuration - endstop pins ;
M574 X1 S1 P"121.io0.in"   
M574 Y2 S1 P"0.io2.in"   
M574 Z1 S2                                                                  

; configuration - bed leveling // lead screw position ;
M671 X-4.5:150:304.5 Y-4.52:305:-4.52 S5
																			                                      
; configuration - extruder and bed heaters/thermistors ;
M308 S0 P"0.temp0" Y"thermistor" T100000 B3950 A"bed"
M950 H0 C"0.out0" T0 Q11
M307 H0 B0 S1.00
M140 H0
M143 H0 S120

;;; this is my M307, find your own
M307 H0 R0.481 K0.479:0.000 D1.84 E1.35 S1.00 B0

; configuration - part fan ;
M950 F1 C"!0.out4+0.out4.tach"
M106 P1 C"Part Fan" S0 H-1                                                 

; configuration - tool0
M308 S1 P"121.temp0" Y"thermistor" T100000 B4725 C7.060000e-8 A"hotend"   
M950 H1 C"121.out0" T1 
;M307 H1 B0 S1.00       
M563 P0 S"revo" D0 H1 F1 
G10 P0 X0 Y0 Z0  
G10 P0 R0 S0  
M143 H1 S280     

;;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;;; run hotend PID tune!! using code below 
;;; ; M303 T0 S210 F0.30
;;;
;;; replace M307 below with results from M303
;;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ;;
;;; this is my new M307, using 4028 fans, E3D Revo hotend, 0.4mm brass nozzle
M307 H1 R2.788 K0.501:0.000 D6.52 E1.35 S1.00 B0 V24.0

; configure hotend fan
M950 F0 C"121.out2" Q250 
M106 P0 C"Tool Fan" S0 H1 T45 L255   

; configuration - extruder
M350 E16 I1		
;;; set extruder steps per mm, 0.9 angle/step
M92 E673.06
;;; max speed mm/min                                                       	    
M203 E7200  
;;; instantaneous speed change mm/min                                                     	    
M566 E300  
;;; acceleration mm/s^2                                                     	    
M201 E10000  
;;; set extruder motor current                                                       	    
M906 E1200 I10                                                         	    

;; filament monitors
;M98 P"0:/sys/filament_monitor.g"

; configuration - z-probe ;
;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

;; Inductive Probe (ezabl, pinda, superpinda, euclid)
M558 P8 C"121.io2.in"  H1.5 F600:120 T12000 A20 B1		
; set Z probe trigger value, offset and trigger height, more Z means closer to the bed			    
; set in build_plate.g macro
M98 P"0:/sys/build_plate.g"
;; define 10x10 mesh grid with point spacing (P10)                                   
; set in setDefaultProbePoints.g for parametric mesh.g
M98 P"0:/sys/setDefaultProbePoints.g"

;Calculate bed centre
if !exists(global.Bed_Center_X)
	global Bed_Center_X = floor(move.axes[0].max / 2)
if !exists(global.Bed_Center_Y)
	global Bed_Center_Y = floor(move.axes[1].max  / 2)
	
; configuration - pressure advance
; set in filament-specific config.g

;;; pull in config-override.g settings
M501

; configuration - accelerometer
M955 P121.0 I54 R10

; pull input_shaping.g
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
