T0                                                            ; select tool 0
M300 S2000 P100                                  ; play beep sound
M291 P"Filament autoloading!" S0 T3   ; display message
M302 P1                                                 ; enable cold extrusion
G4 S1                                                     ; wait for one second
G1 E15 F500                                          ; load filament inside the gears
M109 S235 T0                                        ; set hotend temperature and wait
G1 E200 F500                                        ; extrude 200mm, you may need to reduce speed for very soft TPU
G1 E-10 F1000
M104 S0 T0                                            ; set hotend temperature to 0
M302 P0                                                 ; disable cold extrusion
M291 P"Filament autoload complete!" S0 T3    ; display message