T0         ; ensure the tool is selected

M501	   ; load config-override.g
M703	   ; load filament-specific config.g

M220 S100  ; set speed factor back to 100% in case it was changed
M221 S100  ; set extrusion factor back to 100% in case it was changed
M290 R0 S0 ; clear any baby-stepping
M106 P0 S0 ; turn layer fan off if it is on
M400       ; finish all moves, clear the buffer

G32		   ; 3-point bed leveling

M98 P"0:/sys/build_plate.g" ; pull in build plate parameters 
;							; heightmap, probe height, etc.

M98 P"0:/sys/input_shaping.g" ; pull in input shaping parameters

G90        ; absolute Positioning
M83        ; extruder relative mode

M98 P"0:/sys/setDefaultProbePoints.g" ; reset probe points, just in case

; slicer start code 
;; ideally it should just set & wait for temps
;;  and move to prime line start
