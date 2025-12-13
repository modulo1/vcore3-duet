;M716.g (S1) to engage

;; param.S = 1 to engage
;; param.S = 0 to release

;M98 P"0:/macros/ERCFv2/SERVO_CUTTER.g" S{param.S}

if param.S == 0
    M98 P"0:/macros/ERCFv2/SERVO_CUTTER_RELEASE.g"

if param.S == 1
    M98 P"0:/macros/ERCFv2/SERVO_CUTTER_ENGAGE.g"
