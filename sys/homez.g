; homez.g
; called to home the Z axis
M98 P"0:/sys/configHomingSpeed.g"
M98 P"0:/sys/configBuildPlate.g"

G91                     ; relative positioning
G1 H2 Z10 F120     ; lift Z relative to current position

M400 ; wait for moves to finish

M561 ; clear any bed transform
M290 R0 S0 ; clear babystepping

G90                     ; absolute positioning


; variabes set in Config.g
M401
G1 X{global.bedCenterX - sensors.probes[0].offsets[0] } Y{global.bedCenterY - sensors.probes[0].offsets[1]} F12000
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
M98 P"0:/sys/configMaxSpeed.g"
