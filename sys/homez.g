; homez.g
; called to home the Z axis
;M98 P"0:/sys/checkATX.g"
M566 X200.00 Y200.00 Z10.00 E800.00                          ; set maximum instantaneous speed changes (mm/min)
M203 X1200.00 Y1200.00 Z300.00 E3000.00                  ; set maximum speeds (mm/min)
M201 X400.00 Y400.00 Z60.00 E120.00                        ; set accelerations (mm/s^2)

G91                     ; relative positioning
G1 H2 Z5 F120     ; lift Z relative to current position

M400 ; wait for moves to finish
M913 Z80 ; set X Y Z motors to 80% of their normal current

M561 ; clear any bed transform
M290 R0 S0 ; clear babystepping

G90                     ; absolute positioning

; variabes set in Config.g
G1 X150 Y150 F10000
G1 X{global.Bed_Center_X - sensors.probes[0].offsets[0] } Y{global.Bed_Center_Y - sensors.probes[0].offsets[1]} F12000
M400 ; wait for moves to finish
G30               ; home Z by probing the bed
if result !=0
	abort "Print cancelled due to probe error"

M400 ; wait for moves to finish
M913 X100 Y100 Z100 ; set X Y Z motors to 100% of their normal current

; Uncomment the following lines to lift Z after probing
G91                ; relative positioning
G1 H2 Z5 F100      ; lift Z relative to current position
G90                ; absolute positioning

;reset speeds
M98 P"0:/sys/set_max_speeds.g"
