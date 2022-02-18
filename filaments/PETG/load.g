;; Display message
M291 P"Please wait while the nozzle is being heated up" R"Loading PLA" T5 
;; Set current tool temperature to 250C
G10 S250 
;; Wait for the temperatures to be reached
M116 
;; Display message
M291 P"Feeding filament..." R"Loading PETG" T5 
;; place extruder in relative mode
M83 

;; a lot of filament is used here
;; to ensure color is clean with HF hotend
;;; adjust the Ennn values in the block below to suit

G1 E20 F600 ; Feed 20mm of filament at 600mm/min
G1 E200 F600 ; Feed 200mm of filament at 600mm/min
G1 E30 F300 ; Feed 30mm of filament at 300mm/min

;; wait for nozzle pressure to ease off
;;; P1000 = wait for one (1) second
G4 P1000

;; Retract 10mm of filament at 1800mm/min
;;; this is to back the filament out of the melt zone to minimize oozing
;;; note this value, you will need to adjust the extrusion amount of your 
;;; prime line by the Ennn value below to ensure your prime line prints properly
G1 E-10 F1800 

;; Wait for moves to complete
M400 

;; Hide the message
M292 

;; Turn off the heater
G10 S0 
