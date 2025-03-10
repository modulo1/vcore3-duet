T0 P0        ; ensure the tool is selected

M220 S100  ; set speed factor back to 100% in case it was changed
M221 S100  ; set extrusion factor back to 100% in case it was changed
M290 R0 S0 ; clear any baby-stepping
M106 P0 S0 ; turn layer fan off if it is on
M400       ; finish all moves, clear the buffer

M98 P"0:/sys/configBuildPlate.g" ; pull in build plate parameters
                                 ; heightmap, probe height, etc.

; chamber LEDs on
M98 P"0:/macros/LEDs/1_LED-on.g"

G32        ; 3-point bed leveling

M703       ; load filament-specific config.g

G29

M98 P"0:/sys/configInputShaping.g" ; pull in input shaping parameters

G90        ; absolute Positioning
M83        ; extruder relative mode

;=== DuetLapse3 control ===;
;M291 P"DuetLapse3.start" S2
;M292
;G4 S10

;M98 P"0:/sys/configDefaultProbePoints.g" ; reset probe points, just in case 
;; using SZP now, we scan the whole bed

M98 P"0:/macros/songs/startPrint.g" 

if exists(global.ercfConfigured)
    echo "ERCF configured - running pre-flight check"      
    M98 P"0:/sys/ercf/ercf_start.g"
else
    echo "Starting print."

;M290 S{sensors.probes[1].scanCoefficients[0]} R0
;=== slicer start code follows ===;
