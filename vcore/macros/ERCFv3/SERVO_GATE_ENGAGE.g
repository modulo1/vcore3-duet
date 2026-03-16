;ERCF_SERVO_GATE_ENGAGE.g
;; command for engaging servo for filament gates 

;; note - towerpro and savox appear to be
;;        mirrored (engage and release PWM
;;        amounts are flipped) 

;variables - open/close PWM value
var towerproEngage = 150
var savoxEngage = 80
var servoPWM = 0

;uncomment line for servo being used
;set var.servoPWM = var.towerproEngage
set var.servoPWM = var.savoxEngage

;M280 P10 S150                    ;; towerpro <-- original
;M280 P10 S145                    ;; towerpro

;; towerpro move sequence
;M280 P10 S155                    ;; towerpro
;G4 P500
;M280 P10 S150                    ;; towerpro 
;G4 P500
;M42 P10 S0
;M280 P10 S80                      ;; savox

;G4 P500

;set global.ercfServoEngaged = 1

while true
    if state.gpOut[10].pwm = 0
        echo "Servo disengaged.  Engaging filament gate."
        M280 P10 S{var.servoPWM+5}                  
        G4 P500
        M280 P10 S{var.servoPWM}                  
        G4 P500
        if ceil(state.gpOut[10].pwm) = 1
           echo "Servo engaged.  Turning off."
           M400 
           M42 P10 S0
           set global.ercfServoEngaged = 1
           break
        else 
           continue
