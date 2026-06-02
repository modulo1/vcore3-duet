var x_pos_start = 50
var y_pos_start = 235

var x_pos_ready = 0
var y_pos_ready = 235
;; move to start position
G1 X{var.x_pos_start} Y{var.y_pos_start} F1800

;; deploy servo

M98 P"0:/macros/OPTION/SERVO_CUT_ENGAGE.g"
M400

;; slide crossbow arm into position
G1 X{var.x_pos_ready} Y{var.y_pos_ready} F600

;; engage servo against crossbow arm
M280 P5 S155

;; cut filament
G1 Y{var.y_pos_ready}+20

;; return
G1 Y{var.y_pos_ready}

;; back out to start position
G1 X{var.x_pos_start} Y{var.y_pos_start} F1800

M98 P"0:/macros/OPTION/SERVO_CUT_DISENGAGE.g"
M400