;=== ERCFv2 status report ===:

;; show homed status, loaded/unloaded, servo status
;; filament load status
echo "ERCFv2 on RRF"

if !move.axes[3].homed
  echo "ERROR: ERCF not homed."
else
  echo "ERCF homed."
  
;; report filament load status
M98 P"0:/macros/ERCFv2/STATUS_REPORT_GATE.g"