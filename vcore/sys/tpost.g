echo "Entering tpost" ^ state.currentTool ^".g"

;if !exists(global.ercfConfigured)
    ;echo "No ERCF configured. Nothing to do."    ;; if we accidentally run T0 without ERCF configured
;else
    ;echo "Running commands for " ^ (tools[state.currentTool].name)

;M98 P"0:/macros/ERCFv2/MOVE_SELECTOR_TO.g" S{state.currentTool}

;; feed filament to cutter
if global.ercfServoEngaged = 0
    M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"
else 
    M400

;if state.status = "processing"
;    echo "Printing - moving to purge area..."
;    M98 P"0:/macros/ERCFv2/SYS_TOOL_MOVE_PURGE.g"
;else
;    M400

M98 P"0:/macros/ERCFv2/MOVE_FILAMENT_FEED_TO_CUTTER.g"

;; engage cutter
M98 P"0:/macros/ERCFv2/SERVO_CUTTER_ENGAGE.g"

;; restore hotend for filament loading
M98 P"0:/macros/ERCFv2/SYS_TOOL_TEMP.g" C1



;; feed filament to extruder and load
M98 P"0:/macros/ERCFv2/MOVE_FILAMENT_FEED_TO_EXTRUDER.g"

;; feed filament to hotend. finishing load
M98 P"0:/macros/ERCFv2/MOVE_FILAMENT_FEED_TO_HOTEND.g"


;echo (tools[state.currentTool].name) ^ " loaded..."

if global.ercfServoEngaged = 1
    M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"
else 
    M400

echo "Cleaning nozzle..."
M98 P"0:/macros/ERCFv2/SYS_TOOL_NOZZLE_WIPE.g"
M98 P"0:/macros/ERCFv2/SERVO_WIPER.g" W0
echo "Printing - returning to purge tower..."
M98 P"0:/macros/ERCFv2/SYS_TOOL_MOVE_RESTORE.g"

M400