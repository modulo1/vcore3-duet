; BLTouch
;M280 P0 S160                    ; Precautionary alarm release
;M280 P0 S90                     ; Ensure the pin is raised
;M201 X500.00 Y500.00   			 ; Reduce acceleration for homing moves

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
G30                             ; home Z by probing the bed

G91                             ; relative positioning
G1 Z5 F100                      ; lift Z relative to current position
G90                             ; absolute positioning
