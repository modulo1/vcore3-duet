M98 P"0:/sys/pause.g"
;; relative extruder moves
;M83

;; retract 25mm out of heat zone
;if move.axes[2].machinePosition < 25.00
;   echo "Potiental crash... setting Z=25"
;   G91
;   G1 Z25 F360
;   G90
;elif move.axes[2].machinePosition => 25.00
;   echo "Moving to purge area..."
;   G1 X150 Y280 F6000
;   M400
