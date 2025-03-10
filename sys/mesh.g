;;=== SZP mesh generation ===;;

G29 S2                       ; Disable mesh bed compensation

G1 X155 Y150 Z6


M558.1 K1 S1.0               ; Calibrate probe

G29 S0 K1                    ; Scan bed and create mesh

G1 X18.200 Y41.400 F999999   ; move back behind klicky dock
