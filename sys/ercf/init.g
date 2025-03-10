
;; global declarations for ERCF
;; some defaults established
;; and variables set and loaded

if !exists(global.ercfConfigured)
    global ercfConfigured = 1                                  ;; for toolchange macros
    ;=== configuration - pin definitions ===;
    ;=== configuration - general settings ===;
    global ercfBowdenLength = 630                              ;; how much filament to push before we reach extruder
    global ercfExtruderLengthLoad = 50                         ;; distance to push filament to reach hotend
                                                               ;; VZ-Hextrudort on EVA3 with E3D Revo Voron hotend
    global ercfLoadSpeedFast = 1800
    global ercfLoadSpeedSlow = 600
    ;=== configuration - blinky pulse count ===;
    global ercfPulseCount = 0
    ;global ercfLastCount = 0

    ;=== configuration - selector ===
    global ercfCurrentSelector = 0
    global ercfSelectorLoaded = 0
    global ercfSelectorEngaged = 0
    global ercfSelector = {0,23.5,50,72,95,118,142,165}
    global ercfSelectorOffset = 3.400                          ;; how much to move the selector to align with gate0
    global ercfLoadedGate = {0,0,0,0,0,0,0,0}
    if fileexists("ercf/ercfGateLoadStatus.g")
        M98 P"0:/sys/ercf/ercfGateLoadStatus.g"
else
    abort "ERCF configured. Nothing to do."    
