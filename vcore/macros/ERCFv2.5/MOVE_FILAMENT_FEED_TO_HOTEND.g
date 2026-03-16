;; feed to hoten
;; run immediately after heating hotend 
;; and feed to extruder

;; should be done prior to purge blob
;; or purging to nozzle wiper

set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount

;=== disable blinky as filament monitor ===;
;M98 P"0:/macros/ERCFv2/SYS_FMON_PRE.g"
;M400

M83 ;; relative extrusion mode
G91

;=== show axis ===;
M584 P5
M400

;; check if the selector is loaded
if global.ercfSelectorLoaded = 1
    ;; load filament to extuder, fast
    M302 P1 ;; need cold extrusion for testing
    echo "Loading " ^global.ercfLengthExtruderLoad ^ "mm filament through extruder, slow"
    G1 E{global.ercfLengthExtruderLoad} A{global.ercfLengthExtruderLoad} F{global.ercfSpeedLoadSlow}
    G10
    ;G1 E5 F{global.ercfSpeedLoadSlow}
else
    M400

;M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"

;; hide ercf extruder axis
M584 P4
M302 P0
G90
M400