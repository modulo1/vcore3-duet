; Used to set parameters for filament such as retracts, temperatures etc
M291 P"loading config.g for PLA" R"Loading config" S1 T2
M302 S185 R90 ; set cold extrude and retract temperatures
set global.BedPreheatTemp=60 ; set be preheat variable


;M592 D0:1 A0.012 B0 ; Set non linear extrusion
;;; Pressure Advance
;;; DragonHF
;M572 D0 S0.12
;;; DragonSF
M572 D0 S0.04

M207 S1.5 F7200  Z0.2	; Set retraction

;;; PID tuning command
;M303 H1 S215 F0.4
;;; PID tuning
;M307 H1 R2.654 K0.471:0.000 D6.51 E1.35 S1.00 B0 V24.0
M307 H1 R2.618 K0.633:0.000 D5.24 E1.35 S1.00 B0 V24.0
