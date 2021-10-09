# conventions used 

markdown is needed here

## section formatting

section titles start with '; ' and end with ';'
 ```
; gcode comment blocks start with '; '

; if example gcode needs to be included
;M9999999 C"it will omit the space after
;M77777 A"the last ;"


; this starts a configuration block ; 
;; here we talk a little more about it
;;  moving to a new line and indent one space
;;  if needed to keep width managable
;;; variable definitions start with ';;; '
;;; no more than two per line, like this if possible
;;; longer variables get their own line
M9999 HOO"this is our fake gcode" P"we keep it connected to it's comment block"

;; here's a related configuration section (e.g. heater+sensor)
M88888 P"and more code"

;; sequential command blocks
;;; that are necessary for a particular configuration section
M11111 A"totally fake gcode block" V11 C"should group togather"
;; like this
;;; think pairing fans or thermistors and inputs

;; whereas blocks that are relevant, but not 
;;; necessarily related
M7777777 C"and here's the gcode"

;; don't need to be grouped together

; and we start a new configuration block ; 
;; and so on and so forth
```
## naming conventions

when referring to pin names on the duet and toolboard

define them explictly, starting with board number.

copy and paste this code block near every section 

which references pin names and numbers to remind and reinforce
```
;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;
```
all variables in gcode commands used for configuration should be explicily named and defined

 - we don't need to define movement gcode, but we should describe what we're doing 
   - applies to homeNNN.g, start/pause/resume/stop/cancel.g, etc.

 - including single variable commands

   - with the exception of implied variables for axes' (X, Y, Z, E)

try to keep variable definitions in the following formats:

```
;;; on bed (H0)
;;; B0 = disable bang-bang mode   
;;; and set PWM limit (S1.00) 
M307 H0 B0 S1.00 

[...]

;; Set idle timeout
;;;  S30 = 30s																		                                      
M84 S30  

[...]

;;; configure sensor 0 (S0) on  
;;; pin duet.temp0 (0.temp0) as thermistor on (Y) 
;;; T = thermistor resistance at 25°C
;;; B = beta value
;;; A = named bed
M308 S0 P"0.temp0" Y"thermistor" T100000 B3950 A"bed"

[...]

;;; set fan 0 (P0) to
;;; C = custom name hotend fan
;;; S = fan speed, initial value
;;; H = thermostatic control turned on for hotend fan
;;; T = trigger temperature in celcius; integer or range (T45= 45C) 
;;; L = minimum fan speed (L255 = full speed)                                                  
M106 P0 C"hotend fan" S0 H1 T45 L255   
```
so they can be named and defined in order like shown above, if necessary

