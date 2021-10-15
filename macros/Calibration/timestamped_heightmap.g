; macro
;; create a timestamped heightmap.csv file
;; and load it

;; first we need to set up a few variables
;;; sets the current time and date to var.rightnow
var rightnow = state.time
;;; crafts our filename in the format 'heightmap_DATETIME.csv'
var heightmapFilename = { "heightmap_" ^ var.rightnow ^ ".csv" }

;; if the printer hasn't been home recently, send it there
;;; check our object model to see if homed variables have been set
;;; ! = not, or check if the three axes' have not been homed
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  ;; If axis are not homed, home axis
  ;;; print status
  M291 P"axis not homed yet, homing axis" R"homing status" S1
  ;If axis are not homed, home axis
  echo "axis are not homed, performing homing"
  M98 P"0:/sys/homeall.g"
else
    ;; if already homed, home only the x- and y-axis
    echo "axis are homed, re-homing x and Y"
    ;; run homex.g
    M98 P"0:/sys/homex.g"
    ;; run homey.g
    M98 P"0:/sys/homey.g"
    ;G1 X100 Y100 H0 F1800
    ;; set the current time & date to var.rightnow
    set var.rightnow = state.time
    ;; take the variable we just set and craft our filename
    set var.heightmapFilename = { "heightmap_" ^ var.rightnow ^ ".csv" }
    ;; output the filename to the console in case something goes wrong
    echo var.heightmapFilename
    ;; end check
;; report status
M291 P"Axis homed" R"homing status" S110
;; wait for everything to finish
M400
;; set relative positioning
G91       
; precautionary lift Z relative to current position                     
G1 H2 Z5 F6000                  
;;; Clear the current mesh
G29 S2
;; probe the bed, save the height map as heightmap.csv and load the heightmap
G29 S0
;; save the current height map as a time-stamped file
G29 S3 P{var.heightmapFilename}
;; load the height map we just saved, so we know we're working with the correct file
G29 S1 P{var.heightmapFilename}
;; absolute positioning
G90
