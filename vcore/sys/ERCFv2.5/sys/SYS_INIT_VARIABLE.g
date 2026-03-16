
;; global declarations for ERCF
;; some defaults established
;; and variables set and loaded

if !exists(global.ercfConfigured)
    global ercfConfigured = 1                                  ;; for toolchange macros
    ;=== configuration - pin definitions ===;
    ;=== configuration - distances ===;
    global ercfLengthSelector = 55                             ;; distance from gate exit to expose ~4mm of filament
                                                               ;; retract 46mm to be flush with gate again
    global ercfLengthBowden = 870                              ;; how much filament to push before we reach extruder
                                                               ;; enough for the orbiter gears to grab on to.
    global ercfLengthExtruderLoad = 55                         ;; distance to push filament to load through
                                                               ;; Orbiter 2.5 on MFBS Superlight with Rapido 2 HF hotend
    global ercfLengthToPulse = 12                              ;; distance from gate exit to generate blinky pulses

    ;=== configuration - speeds ===;
    global ercfSpeedLoadFast = 3000
    global ercfSpeedLoadSlow = 300
    
    ;=== configuration - blinky pulse count ===;
    global ercfPulseCount = 0                                  ;; incremented by trigger9.g
    global ercfPulseLoad = 0                                   ;; save the # of pulses during load
                                                               ;; unload until pulses match previous
    ;=== configuration - servo status ===;
    global ercfServoEngaged = 0
    ;=== configuration - selector ===;
    global ercfCurrentSelector = 0
    global ercfSelectorLoaded = 0
    global ercfSelector = {0,23.5,46.5,69.5,92,115.5,138.5,161}
    global ercfSelectorOffset = 3.00                          ;; how much to move the selector to align with gate0
    global ercfGateLoad = {0,0,0,0,0,0,0,0}
    if fileexists("0:/sys/ERCFv2/var/STATUS_CHECK_GATE.g")
        M98 P"0:/sys/ERCFv2/var/STATUS_CHECK_GATE.g"
    ;=== temperatures ===;
    ;global ercfToolTemp = 0         ;; to make changing temp during filament swaps easier
    ;set global.ercfToolTemp = heat.coldExtrudeTemperature
else
    break "ERCF configured. Nothing to do."    