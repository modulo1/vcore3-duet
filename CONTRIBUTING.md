# conventions used 

markdown is needed here

## section formatting

section titles start with '; ' and end with ';'
 ```
; gcode comment blocks start with '; '

; this starts a configuration block ; 
;; here we talk a little more about it
;;  moving to a new line and indent one space
;;  if needed to keep width managable
;;; variable definitions start with ';;; '
;;; no more than two per line, if possible
;;; longer variables get their own line
;M9999 HOO"this is our fake gcode" P"we keep it connected to it's comment block"

;; here's a related configuration section (e.g. heater+sensor)
;M88888 P"and more code"

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
all variables in gcode commands should be explicily named and defined

including single variable commands

 - with the exception of implied variables for axes' (X, Y, Z, E)
