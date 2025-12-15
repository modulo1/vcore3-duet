
;; param.S = 1 to engage
;; param.S = 0 to release

if param.S = 0
    M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"

if param.S = 1 
    M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g" 

