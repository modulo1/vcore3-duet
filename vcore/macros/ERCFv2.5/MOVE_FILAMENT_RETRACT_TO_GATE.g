;; engage gate servo
;; feed filament to cutter slowly
;; engage cutter

;; setup variables
set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount
var ercfSelector = 0
var ercfInitialUnload = 0

;=== disable binky as filament monitor ===;
;; so we can count pulses

;; engage filament gate servo
;M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"
;M400

;; show extruder axis
M584 P5

;; retract filament
;; should end up between binky and gate
G91          ;; set relative movement


;; dwell and wait
M400
G4 P500

;; reset binky pulse count
;set global.ercfPulseCount = 0
;set var.ercfLastCount = global.ercfPulseCount
while true
    if global.ercfSelectorLoaded = 1
        set var.ercfLastCount = global.ercfPulseCount
        G1 A-2 F{global.ercfSpeedLoadSlow}
        G4 P500
        if var.ercfLastCount = global.ercfPulseCount
            set var.ercfInitialUnload = 1
            echo "Unload: 1st pass finished"
            break
        else
            continue
            

echo "Unload: 2nd pass.  Finding Binky."

set global.ercfPulseCount = 0
set var.ercfLastCount = global.ercfPulseCount

while iterations < 40
    if var.ercfLastCount == global.ercfPulseCount 
        ;set var.ercfLastCount = global.ercfPulseCount    
        G1 A1 F{global.ercfSpeedLoadSlow}
        G4 P500
        if global.ercfPulseCount != var.ercfLastCount
            G4 S1
            echo "Found you!"
            G1 A{-global.ercfLengthToPulse-1} F{global.ercfSpeedLoadSlow}
            set global.ercfSelectorLoaded = 0
        else
            echo "Still trying..."
            continue
;while var.ercfLastCount == global.ercfPulseCount
;    G1 A1 F{global.ercfSpeedLoadSlow}
;    if global.ercfPulseCount != var.ercfLastCount
;        G1 A-12
;        echo "Unload complete."


M584 P4
G90
;M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"
M400