;=== filament presence chceck ===;
;; engage servo, wiggle filament, report movement
;; can be run pre-print; should not run during print

set global.ercfPulseCount = 0
var ercfLastCount = global.ercfPulseCount

;=== disable blinky as filament monitor ===;
;M98 P"0:/macros/ERCFv2/SYS_FMON_PRE.g"
M400

;=== engage servo ===;
;M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"

;; enable cold extrusion
;M302 P1

M584 P5                                                              ;; show ERCF extruder axis

;G1 E0:15 F{global.ercfLoadSpeedSlow}                                ;; feed 15mm filament
G1 A15 F{global.ercfSpeedLoadSlow}
M400

if var.ercfLastCount != global.ercfPulseCount
    echo "ERCF_"^global.ercfCurrentSelector^" loaded."
    ;G1 E0:-15 F{global.ercfLoadSpeedFast}
    G1 A-15 F{global.ercfSpeedLoadFast}
    M400
    set global.ercfGateLoad[{global.ercfCurrentSelector}] = 1
else
    echo "ERCF_"^global.ercfCurrentSelector^" not loaded."
    ;G1 E0:-15 F{global.ercfLoadSpeedFast}
    G1 A-15 F{global.ercfSpeedLoadFast}
    set global.ercfGateLoad[{global.ercfCurrentSelector}] = 0
    M400
    
;M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"

;M98 P"0:/macros/ERCFv2/SYS_FMON_POST.g"

;; disable cold extrusion
;M302 P0
M584 P4  ;; hide ERCF extruder axis
M400

    ;set global.ercfSelectorLoaded = 0
;while var.ercfLastCount != global.ercfPulseCount
;    if global.ercfSelectorLoaded == 0
;    G1 E0:-2 F1800
;    echo "ERCF_"^global.ercfCurrentSelector^" loaded."
