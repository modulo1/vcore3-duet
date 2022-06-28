; Used to set parameters for filament such as retracts, temperatures etc
M291 P"loading config.g for PET" R"Loading config" S1 T2
M302 S200 R120 ; set cold extrude and retract temperatures
set global.BedPreheatTemp=70 ; set be preheat variable


;M592 D0:1 A0.012 B0 ; Set non linear extrusion

M572 D0 S0.06 ;Set pressure advance

M207 S2.0 F9000 Z0.2	; Set retraction

;;; PID tuning command
;M303 H1 S245 F0.4
;;; PID Tuning for 245C and fan at 40%
;M307 H1 R2.788 K0.501:0.000 D6.52 E1.35 S1.00 B0 V24.0
M307 H1 R2.561 K0.508:0.000 D5.38 E1.35 S1.00 B0 V24.0
