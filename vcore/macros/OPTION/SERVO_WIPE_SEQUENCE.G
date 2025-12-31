;; nozzle preheat and wipe motion
;; to be called during homing z


var end_pos_x = 250
var end_pos_y = 240

var start_pos_x = 250
var start_pos_y = 290

var wipe_speed = 12000

G90                                                         ;; set absolute positioning
G1 Z25                                                      ;; move bed below wiper

;M201 X500 Y500                                              ;; reduce acceleration

;; move behind brush
G1 X{var.start_pos_x} Y{var.start_pos_y} F{var.wipe_speed}

M98 P"0:/macros/option/SERVO_WIPE_ENGAGE.g"                 ;; move wiper above bed
M400

;; set nozzle standby temp to cold extrude temp
M568 S180 A2 P0
M116 P0

G4 S5

;; wipe 4x

M98 P"0:/macros/OPTION/SERVO_WIPE_MOVE_FB.g"
M400

M98 P"0:/macros/OPTION/SERVO_WIPE_MOVE_LR.g"
M400 

;; move behind brush
G1 X{var.start_pos_x} Y{var.start_pos_y} F{var.wipe_speed}

;; cooldown wipe sequence
M98 P"0:/macros/OPTION/SERVO_WIPE_COOLDOWN.g"
M400

;; reset speeds
M98 P"0:/macros/config/configMaxSpeed.g"
M400

;; move back to center
G1 X{global.bedCenterX - sensors.probes[1].offsets[0]} Y{global.bedCenterY - sensors.probes[1].offsets[1]} F{var.wipe_speed}
M400

;; retract brush
M98 P"0:/macros/option/SERVO_WIPE_DISENGAGE.g"
M400

