var start_pos_x = 252
var start_pos_y = 285

var wipe_speed = 12000

var purge_pos_y = {var.start_pos_y-(state.currentTool*5)}

;; ensure absolute movement
G90


;var exTemp = 190

;if exists(param.C)

if move.axes[2].machinePosition < 25.00
   echo "Potential crash; minimum Z=25" 
   G1 Z25 F3000
elif move.axes[2].machinePosition => 25.00
   M400

;; move behind brush
G1 X{var.start_pos_x} Y{var.start_pos_y} F{var.wipe_speed}
M400
;; engage servo wiper
M98 P"0:/macros/ERCFv2/SERVO_WIPER.g" W1

;; move to purge position over brush, offset by gate #
G1 X{var.start_pos_x} Y{var.purge_pos_y} F{var.wipe_speed}

M400