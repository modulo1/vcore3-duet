echo "Entering tpre" ^ state.nextTool ^".g"

;; make sure filament gate servo is released
if global.ercfServoEngaged = 1
    M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"
else 
    M400

;; make sure cutter is open before moving
M98 P"0:/macros/ERCFv2/SERVO_CUTTER_RELEASE.g"

;; move to next tool
M98 P"0:/macros/ERCFv2/MOVE_SELECTOR_TO.g" S{state.nextTool}
M400