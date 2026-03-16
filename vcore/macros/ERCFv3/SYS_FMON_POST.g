;ERCF_SYS_FMON_POST.g

;; unsets trigger and re-enables filament monitor

M581 T9 P-1                                ;; unset trigger T9
M950 J2 C"nil"                             ;; unset pin J2

M591 D1 P7 C"^19.io1.in" S1 A1 L1.000       ;; set filament monitor, new(?), blinky


;M591 D1 P7 C"^0.io5.in" S1 A1 L1.331       ;; set filament monitor, old(?), pre-blinky
