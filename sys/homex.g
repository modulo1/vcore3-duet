; homex.g - ratrig configuration
G91								; relative positioning
;G1 H2 Z-5 F6000						; lift Z relative to current position
G1 H1 X-625 F1800					; move quickly to X axis endstop and stop there (first pass)
G1 H2 X5 F6000						; go back a few mm
G1 H1 X-625 F360					; move slowly to X axis endstop once more (second pass)
;G1 H2 Z-5 F6000					; lower Z again
G90								; absolute positioning

; homex.g - sensorless homing configuration
;M400
;M913 X70 Y70						; drop motor current to 70%
;M400 G91							; relative positioning
;G1 H2 Z10 F12000					; lift Z relative to current position
;G1 H1 X-320.5 F10000				; move quickly to X axis endstop and stop there (first pass)
;G1 H2 X5 F12000						; go back a few mm
;G1 H1 X-320.5 F7000					; move slowly to X axis endstop once more (second pass)
;G1 H2 Z-10 F6000					; lower Z again
;G90									; absolute positioning
;M400
;M913 X100 Y100						; return current to 100%
;M400
