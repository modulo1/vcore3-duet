;; nozzle preheat and wipe motion
;; to be called during homing z


;; x-pos X250
;; y-pos Y220

;; wipe-x-pos X250
;; wipe-y-pos Y290


var end_pos_x = 247
var end_pos_y = 220

var start_pos_x = 252
var start_pos_y = 290

var wipe_speed = 12000

G90                                                         ;; set absolute positioning

G1 X{var.start_pos_x} Y{var.start_pos_y} F{var.wipe_speed}

;; choose tool for nozzle heating

G4 S1

;; wipe 2x
M98 P"0:/macros/option/SERVO_WIPE_MOVE_GYR1.g" F{var.wipe_speed/2}
M400

M98 P"0:/macros/option/SERVO_WIPE_MOVE_GYR2.g" F{var.wipe_speed}
M400

;; move behind brush
G1 X{var.start_pos_x} Y{var.start_pos_y} F{var.wipe_speed}

M400

G4 P500

M400


