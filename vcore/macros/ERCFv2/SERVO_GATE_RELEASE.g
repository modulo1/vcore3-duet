;SERVO_GATE_RELEASE.g
;; used to release servo for filament gates

;; note - towerpro and savox appear to be
;;        mirrored (engage and release PWM
;;        amounts are flipped) 

M280 P10 S125                      ;; towerpro


;M280 P10 S125                     ;; savox

G4 P200
M42 P10 S0

set global.ercfServoEngaged = 0

M400