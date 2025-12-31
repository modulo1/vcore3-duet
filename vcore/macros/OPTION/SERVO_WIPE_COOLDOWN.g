;; macro runs as part of nozzle wipe sequence
;; should not be run standalone

var end_pos_x = 250
var end_pos_y = 240

var start_pos_x = 250
var start_pos_y = 290

var wipe_speed = 300

;; make sure we're behind brush
G1 X{var.start_pos_x} Y{var.start_pos_y}

;; heater on standby if printing, else off
if exists(job.build)
    echo "Printing - setting to standby-low temp"
    M568 S100 A2 P0
else
    M568 P0 S0 A2
    echo "Not printing - turning heater off"

;; part cooling fan on
M106 S192

;; wait 5 seconds
G4 S5

;; wipe through brush as cooling down
G1 Y{var.end_pos_y} F{var.wipe_speed}

;; part cooling fan off
M106 S0

