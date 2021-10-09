conventions used 

section titles start with '; ' and end with ';'
 
; comment blocks start with '; '
;; additional comments start with ';; '
;;  and since this is a new line, we add an
;;  additional space

; this starts a configuration block ; 
;; here we talk a little more about it
;;  moving to a new line if needed to
;;  keep width managable
;M9999 HOO"this is our fake gcode" P"we keep it connected to it's comment block"

;; here's a related configuration section (e.g. heater+sensor)
;M88888 P"and more code"

; and we start a new configuration block ; 
;; and so on and so forth

when referring to pin names on the duet and toolboard
define them explictly, starting with board number.
copy and paste this code block near every section 
which references pin names and numbers

;; duet pins start with 0. ;;
;; toolboard 1lc pins start with 121. ;;

all variables in gcode commands need to be explicityly named and defined
with the exception of implied variables for axes' (X, Y, Z, E)


