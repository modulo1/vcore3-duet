;; extruder, fast unload sequence

;; retract filament out of extruder, fast

G91

if global.ercfServoEngaged == 1
    M302 P1
    M584 P5
    G1 A{-global.ercfLengthExtruderLoad-10} E{-global.ercfLengthExtruderLoad-10} F{global.ercfSpeedLoadFast}

;; dwell
G4 P500
G90
M302 P0
M584 P4
M400