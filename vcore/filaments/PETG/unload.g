;; Display message
M291 P"Please wait while the nozzle is being heated up" R"Unloading PETG" T5
;; Set current tool temperature to 250C
G10 S250 
;; Wait for the temperatures to be reached
M116 
;; Display message
M291 P"Retracting filament..." R"Unloading PLA" T5 

G1 E-20 F300 ; Retract 20mm of filament at 300mm/min
G1 E-480 F3000 ; Retract 480mm of filament at 3000mm/min

;; Wait for moves to complete
M400 
;; Hide the message
M292 

;; Turn off the heater
G10 S0 
