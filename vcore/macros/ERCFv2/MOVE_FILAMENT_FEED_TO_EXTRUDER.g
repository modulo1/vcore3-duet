;=== filament presence chceck ===;
;; engage servo, wiggle filament, report movement
;; can be run pre-print; should not run during print

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
    echo "Loading " ^global.ercfLengthBowden ^ "mm filament to extruder, fast"
    G1 A{global.ercfLengthBowden} F{global.ercfSpeedLoadFast}
    ;; load filament to melt zone, slow
    M302 P1 ;; need cold extrusion for testing
    echo "Loading " ^global.ercfLengthExtruderLoad ^ "mm filament through extruder, slow"
    G1 E{global.ercfLengthExtruderLoad} A{global.ercfLengthExtruderLoad} F{global.ercfSpeedLoadSlow}
    ;G1 E5 F{global.ercfSpeedLoadSlow}

set global.ercfPulseLoad = global.ercfPulseCount

;M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"

;; hide ercf extruder axis
M584 P4
M302 P0
G90
M400