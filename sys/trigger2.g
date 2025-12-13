T0                                                            ; select tool 0
M300 S2000 P100                                  ; play beep sound
M291 P"Filament autoloading!" S0 T3   ; display message
M302 P1                                                 ; enable cold extrusion
G4 S1                                                     ; wait for one second
G1 E15 F500                                          ; load filament inside the gears
M109 S235 T0                                        ; set hotend temperature and wait
G1 E150 F500                                        ; extrude 100mm, you may need to reduce speed for very soft TPU
G4 P1000

;; Retract 10mm of filament at 1800mm/min
;;; this is to back the filament out of the melt zone to minimize oozing
;;; note this value, you will need to adjust the extrusion amount of your 
;;; prime line by the Ennn value below to ensure your prime line prints properly
G1 E-10 F1800 

;; Wait for moves to complete
M400 
M104 S0 T0                                            ; set hotend temperature to 0
M302 P0                                                 ; disable cold extrusion
M291 P"Filament autoload complete!" S0 T3    ; display message