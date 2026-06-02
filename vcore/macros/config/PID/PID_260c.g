;;; PID tuning command
;M303 T0 P1 S260 F0.2
;M307 H1 R3.837 K0.624:0.216 D5.49 E1.35 S1.00 B0 V0.0        ;; rapido2uhf pt1000
;M307 H1 R4.338 K0.635:0.312 D5.38 E1.35 S1.00 B0 V0.0          ;; rapido2uhf pt1000, max31865
M307 H1 R8.197 K0.917:0.692 D0.89 E1.35 S1.00 B0 V0.0           ;; rapido2uhf, new-style pt1000, max31865
M307 H1 R7.075 K0.777:0.642 D1.21 E1.35 S1.00 B0 V0.0            ;; rapido2hf, pt1000, max31865, 4010 fan