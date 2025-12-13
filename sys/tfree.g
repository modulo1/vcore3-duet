
echo "Entering tfree" ^ state.currentTool ^".g"
;if !exists(global.ercfConfigured)
;    echo "No ERCF configured. Nothing to do."    ;; if we accidentally run T0 without ERCF configured
;else
echo "Running commands to free " ^ (tools[state.currentTool].name)


G60 S4                                       ;; save current position (S4)
                                             ;; should be at start of purge tower
                                             ;; or at initial purge position +X-Y

M98 P"0:/macros/ERCFv2/SYS_TOOL_MOVE_PURGE.g"
    
echo "Checking for filament..."

if global.ercfServoEngaged = 0
    M98 P"0:/macros/ERCFv2/SERVO_GATE_ENGAGE.g"
else 
    M400

;; cool hotend to avoid blobs
M98 P"0:/macros/ERCFv2/SYS_TOOL_TEMP.g" C0

if global.ercfSelectorLoaded = 1
    echo "ERCF selector loaded.  Unloading filament back to cutter."
    M98 P"0:/macros/ERCFv2/MOVE_FILAMENT_RETRACT_TO_CUTTER.g"
    echo "Unloading filament back to gate."
    M98 P"0:/macros/ERCFv2/MOVE_FILAMENT_RETRACT_TO_GATE.g"
    M98 P"0:/macros/ERCFv2/SERVO_CUTTER_RELEASE.g"
    echo "Cutting tip for next load..."
    M98 P"0:/macros/ERCFv2/MOVE_FILAMENT_FEED_TO_CUTTER.g"
    M98 P"0:/macros/ERCFv2/SERVO_CUTTER_ENGAGE.g"
    M98 P"0:/macros/ERCFv2/SERVO_CUTTER_RELEASE.g"
    M98 P"0:/macros/ERCFv2/MOVE_FILAMENT_RETRACT_TO_GATE.g"
    ;echo "ERCF selector unloaded. Moving selector to "^{tools[state.nextTool].name}
    if global.ercfServoEngaged = 1
        M98 P"0:/macros/ERCFv2/SERVO_GATE_RELEASE.g"
    else 
        M400
else
    ;echo "ERCF selector unloaded. Moving selector to "^{tools[state.nextTool].name}
    M400
M400