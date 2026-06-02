;;; PID Tuning for 245C and fan at 50%
;;; M303 T0 P1 S240 F0.4 
;M307 H1 R3.283 K0.573:0.471 D2.09 E1.35 S1.00 B0 V23.5      ;; e3d revo heatercore
;M307 H1 R2.461 K0.262:0.490 D6.83 E1.35 S1.00 B0 V0.0        ;; dragonHF, 60W heater
;M307 H1 R2.786 K0.526:0.165 D7.54 E1.35 S1.00 B0 V0.0          
;M307 H1 R2.641 K0.344:0.396 D8.40 E1.35 S1.00 B0 V0.0         ;; dragonSF, 60W, 2510
;;M307 H1 R3.837 K0.624:0.216 D5.49 E1.35 S1.00 B0 V0.0        ;; rapido2uhf pt1000, temp0
;M307 H1 R4.338 K0.635:0.312 D5.38 E1.35 S1.00 B0 V0.0          ;; rapido2uhf pt1000, max31865
;M307 H1 R8.197 K0.917:0.692 D0.89 E1.35 S1.00 B0 V0.0           ;; rapido2uhf, new-style pt1000, max31865
M307 H1 R7.075 K0.777:0.642 D1.21 E1.35 S1.00 B0 V0.0            ;; rapido2hf, pt1000, max31865, 4010 fan
