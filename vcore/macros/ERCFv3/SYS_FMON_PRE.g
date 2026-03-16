;ERCF_SYS_FMON_PRE.g

;; disables filament monitoring, sets blinky as simple trigger

M591 D1 S0 P0                 ;; disable filament monitoring


M950 J2 C"^19.io1.in"         ;; set blinky on J2 as simple trigger
M581 T9 P2                    ;; set trigger T9 for filament loading