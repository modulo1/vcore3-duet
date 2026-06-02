;; check if ERCF selector is homed
if !move.axes[3].homed
  echo "Error: ERCF not homed; homing first"
  M98 P"0:/macros/ERCFv2/MOVE_SELECTOR_HOME.G"
  if result != 0
        break "Error: Print cancelled due to homing error"

while iterations < #{global.ercfGateLoad}

    M98 P"0:/macros/ERCFv2/MOVE_SELECTOR_TO.g" S{iterations}  ;; move selector to tool
    
    M98 P"0:/macros/ERCFv2/MOVE_FILAMENT_CHECK.g"           ;; feed filament, report 

echo >"0:/sys/ERCFv2/var/STATUS_CHECK_GATE.g" "set global.ercfGateLoad =", global.ercfGateLoad

echo {global.ercfGateLoad}