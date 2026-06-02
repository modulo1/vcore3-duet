;; called when exists(global.ercfConfigured) returns true
;; during start.g 

echo "ERCF pre-flight check"

if !move.axes[3].homed
    G28 V
    echo "Homing Selector..."
else
    echo "ERCF homed... "

echo "Checking filament gate load/unload status..."

M98 P"0:/sys/homea.g"

;M98 P"0:/macros/ERCFv2/STATUS_CHECK_GATE.g"

M98 P"0:/macros/ERCFv2/STATUS_REPORT_GATE.g"

;if state.currentTool != -1
;    echo {tools[state.currentTool].name} ^ " is selected."
;    echo "Running toolchange sequence..."
;    T-1 P0 ; P0 for now...

T-1 P0

echo "Starting print with ERCF..."
M98 P"0:/macros/songs/mario_theme.g"