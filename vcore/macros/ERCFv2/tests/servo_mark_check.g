;ERCF_SERVO_GATE_ENGAGE.g
;; command for engaging servo for filament gates 

;; note - towerpro and savox appear to be
;;        mirrored (engage and release PWM
;;        amounts are flipped) 

;M280 P10 S150                    ;; towerpro <-- original
;M280 P10 S145                    ;; towerpro

;; towerpro move sequence
M280 P10 S155                    ;; towerpro
G4 P500
M280 P10 S150                    ;; towerpro 
G4 P500

M400

if ceil(state.gpOut[10].pwm) = 1
    echo "Servo engaged. Turning off."
    M42 P10 S0
    M400
    set global.ercfServoEngaged = 1
else 
    echo "Servo error. Aborting."
    abort



;M280 P10 S80                      ;; savox

;G4 P500

