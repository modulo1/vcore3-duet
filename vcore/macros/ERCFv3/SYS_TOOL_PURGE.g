;; nozzle heat, purge and wipe motion
;; to be called during toolchange

;; load the filament right up to the nozzle
;; over the wiper brush

;; MOVE AS LITTLE FILAMENT AS POSSIBLE ;;
;; JUST ENOUGH TO AVOID BLOBS ;;

;; pass param.D for tool number
;; pass param.C for cooling/heating

;; x-pos X250
;; y-pos Y220

;; wipe-x-pos X250
;; wipe-y-pos Y290


var start_pos_x = 252
var start_pos_y = 290

var wipe_speed = 12000

var purge_pos_y = {start_pos_y-(param.D*5)}

;var exTemp = 190

G90                                                         ;; set absolute positioning
G1 Z25                                                      ;; move bed below wiper

;; move behind brush
;G1 X{var.start_pos_x} Y{var.start_pos_y} F{var.wipe_speed}

;M98 P"0:/macros/option/SERVO_WIPE_ENGAGE.g"                 ;; move wiper above bed

;; heat or cool tool as needed
;M98 P"0:/macros/ERCFv2/SYS_TOOL_TEMP.g" C{param.C}

;; wait for temp
M116 P{state.currentTool}

G4 S1

;; wipe 4x
M98 P"0:/macros/option/SERVO_WIPE_MOVE_GYR1.g" F{var.wipe_speed/2}
M400

M98 P"0:/macros/option/SERVO_WIPE_MOVE_GYR2.g" F{var.wipe_speed}
M400

;M98 P"0:/macros/option/SERVO_WIPE_MOVE_GYR1.g" F{var.wipe_speed/3}
;M400

;M98 P"0:/macros/option/SERVO_WIPE_MOVE_GYR2.g" F{var.wipe_speed}
;M400 

;; move behind brush
G1 X{var.start_pos_x} Y{var.start_pos_y} F{var.wipe_speed}


M400

;; retract brush
M98 P"0:/macros/option/SERVO_WIPE_DISENGAGE.g"

G4 P500

;; heater on standby if printing, else off
;if exists(job.build)
;    echo "Printing - setting to standby temp"
;    M104 S100
;else
;    M104 S0
;    T-1 P0
;    echo "Not printing - turning heater off"

;; reset speeds
;M98 P"0:/sys/configOrcaSpeeds.g"

;; move back to center
;G1 X{global.bedCenterX - sensors.probes[1].offsets[0]} Y{global.bedCenterY - sensors.probes[1].offsets[1]} F{var.wipe_speed}

M400


