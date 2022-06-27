; homeall.g
; called to home all axes
;
; generated by RepRapFirmware Configuration Tool v2.1.4 on Sat Jan 04 2020 09:46:45 GMT+1000 (Australian Eastern Standard Time)
;M98 P"0:/sys/checkATX.g"
set global.Cancelled = false
;lower speeds for homing
M566 X200.00 Y200.00 Z10.00 E800.00                          ; set maximum instantaneous speed changes (mm/min)
M203 X1200.00 Y1200.00 Z300.00 E6000.00                  ; set maximum speeds (mm/min)
M201 X400.00 Y400.00 Z60.00 E120.00                        ; set accelerations (mm/s^2)

G91                             ; relative positioning
G1 H2 Z5 F6000                  ; lift Z relative to current position
G1 H1 X-625 Y605 F3600          ; move quickly to X and U axis endstops and stop there (first pass)
G1 H1 X-625 F1800               ; move quickly to X and U axis endstops and stop there (first pass)
G1 H1 Y605 F1800                ; move quickly to X and U axis endstops and stop there (first pass)
G1 H2 X5 Y-5 F600              ; go back a few mm
G1 H1 X-625 Y605 F360           ; move slowly to X and U axis endstops once more (second pass)
G1 H1 X-625 F360                ; move slowly to X and U axis endstops once more (second pass)
G1 H1 Y605 F360                 ; move slowly to X and U axis endstops once more (second pass)

G90                             ; absolute positioning
G1 X150 Y150 F10000             ; go to first probe point
G1 X{global.Bed_Center_X - sensors.probes[0].offsets[0] } Y{global.Bed_Center_Y - sensors.probes[0].offsets[1]} F12000
G30                             ; home Z by probing the bed

;reset speeds
M913 X100 Y100 Z100 ; set X Y Z motors to 100% of their normal current
M98 P"0:/sys/set_max_speeds.g"

; Uncomment the following lines to lift Z after probing
G91                    ; relative positioning
G1 H2 Z5 F120          ; lift Z relative to current position
G90                    ; absolute positioning
