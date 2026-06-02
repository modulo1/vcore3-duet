;; engage gate servo
;; feed filament to cutter slowly
;; engage cutter

;; setup variables
set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount
var assertProceed = 0

;=== show ERCF extruder axis ===;
M584 P5

G91

M302 P1 ;; for testing

;; engage servo
;M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"

;M302 P1

;; back filament out of extruder, slow
;G1 A{-global.ercfLengthExtruderLoad+10} E{-global.ercfLengthExtruderLoad+10} F{global.ercfSpeedLoadFast}



;; reset pulse count for unload, fast
;; set global.ercfPulseCount = 0

;; dwell
;G4 P500
;G1 A{-global.ercfLengthBowden+10} F{global.ercfSpeedLoadFast}

if global.ercfSelectorLoaded = global.ercfServoEngaged
    set var.assertProceed = true

while iterations < 10
    if var.ercfLastCount == global.ercfPulseCount
        G1 A-2 E-2 F{global.ercfSpeedLoadSlow}
        if var.ercfLastCount != global.ercfPulseCount
           echo "Filament movement. Unloading from extruder, fast."
           G1 A{-global.ercfLengthExtruderLoad-10} E{-global.ercfLengthExtruderLoad-10} F{global.ercfSpeedLoadFast}
           echo "Extruder cleared.  Unloading to filament cutter, fast."
           G1 A{-global.ercfLengthBowden} E{-global.ercfLengthExtruderLoad} F{global.ercfSpeedLoadFast}
        else
           continue

;if var.ercfLastCount == global.ercfPulseCount
;       ;; move ERCF-A and E-axis together to check for filament movement
;       G1 A-2 E-2 F{global.ercfSpeedLoadSlow}
;       if var.ercfLastCount != global.ercfPulseCount
;           echo "Filament movement. Unloading from extruder, fast."
;           G1 A{-global.ercfLengthExtruderLoad-10} E{-global.ercfLengthExtruderLoad-10} F{global.ercfSpeedLoadFast}
;           echo "Extruder cleared.  Unloading to filament cutter, fast."
;           G1 A{-global.ercfLengthBowden} E{-global.ercfLengthExtruderLoad} F{global.ercfSpeedLoadFast}
;        else
;    echo "Selector not loaded.  Servo not engaged."   


;; unload filament
;if global.ercfSelectorLoaded == 1
;; engage filament gate servo
;    M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"
;    M400
;    ;; back filament out of hot end, slow
;    G1 A{-global.ercfLengthExtruderLoad} E{-global.ercfLengthExtruderLoad} F{global.ercfSpeedLoadSlow}
    
    ;; back filament out to selector, fast
    ;; should leave 5mm of filament to cut
;    G1 A{-global.ercfLengthBowden-5} F{global.ercfSpeedLoadFast}
;    M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"



;set global.ercfExtruderLoaded = 0

M584 P4


G90

M302 P0

;M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"
M400