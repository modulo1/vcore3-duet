; homez.g
; called to home the Z axis
M98 P"0:/sys/setHomingSpeed.g"

G91                     ; relative positioning
G1 H2 Z5 F120     ; lift Z relative to current position

M400 ; wait for moves to finish

M561 ; clear any bed transform
M290 R0 S0 ; clear babystepping

;check BL Touch
;if sensors.probes[0].value[0]=1000 ; if probe is in error state
;	echo "Probe in error state- resetting"
;	M280 P0 S160 ; reset BL Touch
;	G4 S0.5
;if state.gpOut[0].pwm=0.03
;	echo "Probe is already deployed - retracting"
;	M280 P0 S80 ; retract BLTouch
;	G4 S0.5

;if sensors.endstops[2].triggered
;	echo "Probe ia already triggered - resetting"
;	M280 P0 S160 ; reset BL Touch
;	G4 S0.5

G90                     ; absolute positioning


; variabes set in Config.g
M401
G1 X150 Y150 F10000
G1 X{global.Bed_Center_X - sensors.probes[0].offsets[0] } Y{global.Bed_Center_Y - sensors.probes[0].offsets[1]} F12000
M400 ; wait for moves to finish
G30               ; home Z by probing the bed
if result !=0
	abort "Print cancelled due to probe error"

M400 ; wait for moves to finish

; Uncomment the following lines to lift Z after probing
G91                ; relative positioning
G1 H2 Z5 F100      ; lift Z relative to current position
G90                ; absolute positioning
M402
;G1 X{global.Bed_Center_X - sensors.probes[0].offsets[0] } Y{global.Bed_Center_Y - sensors.probes[0].offsets[1]} F12000
;reset speeds
M98 P"0:/sys/setMaxSpeed.g"
