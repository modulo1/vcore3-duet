;T0 P0         ; ensure the tool is selected

M220 S100  ; set speed factor back to 100% in case it was changed
M221 S100  ; set extrusion factor back to 100% in case it was changed
M290 R0 S0 ; clear any baby-stepping
M106 P0 S0 ; turn layer fan off if it is on
M302 P0
M400       ; finish all moves, clear the buffer

M703       ; load filament-specific config.g

M98 P"0:/macros/config/configInputShaping.g" ; pull in input shaping parameters
M98 P"0:/macros/config/configBuildPlate.g" ; pull in build plate parameters
                                 ; heightmap, probe height, etc.

;; chamber LEDs on
M98 P"0:/macros/LEDs/1_LED-on.g"


;; home Z, tram bed
G28 Z
G32        

;; generate heightmap mesh
G29

G90        ; absolute Positioning
M83        ; extruder relative mode

;=== DuetLapse3 control ===;
;M291 P"DuetLapse3.start" S2
;M292
;G4 S10

;M98 P"0:/sys/configDefaultProbePoints.g" ; reset probe points, just in case 
;; using SZP now, we scan the whole bed

;; load mesh
G29 S1 

;; move to prime blob location
M98 P"0:/macros/print/movePrimeblob.g"

;; play the song
M98 P"0:/macros/songs/startPrint.g" 

if exists(global.ercfConfigured)
    echo "ERCF configured - running pre-flight check"      
    M98 P"0:/sys/ERCFv2/sys/start.g"
else
    T0 P0         ; ensure the tool is selected
    echo "Starting print."

;=== slicer start code ===;
M400