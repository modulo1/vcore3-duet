;Auto unload filament macro

T0                                                         ; select tool 0

M300 S4000 P100                               ; play beep sound
M291 P"Filament unloading!" S0 T3   ; display message

M109 S235 T0                                     ; set hotend temperature to 235 and wait

G0 E-5 F3600                                      ; extract filament to cold end
G4 S3                                                  ; wait for 3 seconds
G0 E5 F3600                                       ; push back the filament to strive stringing
G0 E-15 F3600                                    ; Extract fast in the cold zone
G1 E-480 F3600
;G0 E-170 F300                                      ; continue extraction slow allow filament to be cooled enough before reaches the gears

M104 S0 T0                                         ; set hotend temperature to 0

M291 P"Filament unload complete!" S0 T3   ; display message