;; servos like to jump when they're enabled
;; the filament cutter especially will mangle 
;; any loaded filament if it moves while loaded

;; enable servos after manually clearing ERCFv2
M950 S5 C"0.io2.out"                      ;; filament cutter
M950 S10 C"19.io0.out"                    ;; tophat servo

G4 S5

M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"
M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"

M98 P"0:/macros/ERCFv2/SERVO_CUTTER_ENGAGE.g"
M98 P"0:/macros/ERCFv2/SERVO_CUTTER_RELEASE.g"

M400