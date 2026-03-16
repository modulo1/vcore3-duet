;ERCF_SELECTOR_MOVE.g S[paramGateNumber]

var tool = null
var ok = false

if global.ercfServoEngaged = 1
   echo "Filament servo engaged or selector loaded.  Cannot move."

if !move.axes[3].homed
  echo "Error: ERCF not homed; homing first"
  M98 P"0:/macros/ERCFv2/MOVE_SELECTOR_HOME.G"
  if result != 0
        echo "Error: Print cancelled due to homing error"

if exists(param.S)
    set var.tool = global.ercfSelector[param.S]
    set var.ok = true
else
    set var.ok = false

if var.ok && move.axes[3].homed
    echo "Moving to "^(tools[param.S].name)
    G1 V{var.tool} F3000
    set global.ercfCurrentSelector = param.S
else
    break "Error: missing paramS or MOVE_SELECTOR_HOME.G"
M400