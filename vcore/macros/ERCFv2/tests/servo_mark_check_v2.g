;ERCF_SERVO_GATE_ENGAGE.g
;; command for engaging servo for filament gates 

;; note - towerpro and savox appear to be
;;        mirrored (engage and release PWM
;;        amounts are flipped) 

;M280 P10 S150                    ;; towerpro <-- original
;M280 P10 S145                    ;; towerpro

while true
    if state.gpOut[10].pwm = 0
        echo "Servo disengaged.  Engaging filament gate."
        M280 P10 S145                    ;; towerpro
        G4 P500
        M280 P10 S150                    ;; towerpro 
        G4 P500
        if ceil(state.gpOut[10].pwm) = 1
           echo "Servo engaged.  Turning off."
           M400 
           M42 P10 S0
           set global.ercfServoEngaged = 1
           break

;M280 P10 S80                      ;; savox

;G4 P500

