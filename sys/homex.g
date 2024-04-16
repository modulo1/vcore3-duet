; homex.g
; called to home the X axis
;
; generated by RepRapFirmware Configuration Tool v2.1.4 on Sat Jan 04 2020 09:46:45 GMT+1000 (Australian Eastern Standard Time)
M400 ; wait for moves to finish
;lower speeds for homing
M98 P"0:/sys/setHomingSpeed.g"

G91               ; relative positioning

G1 H2 Z5 F120

G1 H1 X-625 F1800					; move quickly to X axis endstop and stop there (first pass)

if result != 0
	abort "Error during fast homing X axis - process cancelled"
	
;G1 H2 X5 F6000						; go back a few mm
G1 X5 F6000						; go back a few mm

G1 H1 X-625 F360					; move slowly to X axis endstop once more (second pass)
if result != 0
	abort "Error during slow homing X axis - process cancelled"
;G1 H2 Z-5 F6000					; lower Z again
;G90								; absolute positioning
;G1 H2 Z5 F120    ; lift Z relative to current position
;G1 H1 X-625 F1200 ; move quickly to X axis endstop and stop there (first pass)
;if result != 0
;	abort "Error duing fast homing X axis - process cancelled"
;G1 H2 X5 F1200    ; go back a few mm
;G1 H1 X-625 F360  ; move slowly to X axis endstop once more (second pass)
;if result != 0
;	abort "Error duing slow homing X axis - process cancelled"
G1 H2 Z-5 F120   ; lower Z again
G90               ; absolute positioning
M400 ; wait for moves to finish
M98 P"0:/sys/setMaxSpeed.g" ; reset max speeds
