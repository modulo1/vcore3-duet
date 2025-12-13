; homez.g
; called to home the Z axis
M98 P"0:/macros/config/configBuildPlate.g"
;M98 P"0:/macros/config/configHomingSpeed.g"

M290 R0 S0

;; make sure wiper is retracted
M98 P"0:/macros/OPTION/SERVO_WIPE_DISENGAGE.g"

; Step 0: move to a safe probing position

M564 H0                    ; unlock movement 

G91                        ; relative positioning

G1 H0 Z20 F6000            ; lift Z a bit to ensure we arent too close to the bed -- H2 is outdated and not used anymore. H1 respects endstops, H0 ignores them.

G90                        ; absolute positioning

G1 X{global.bedCenterX - sensors.probes[1].offsets[0] } Y{global.bedCenterY - sensors.probes[1].offsets[1]} F12000     ; move probe to bed center
;G1 X{global.bedCenterX} Y{global.bedCenterY} F12000

M913 Z55                   ; 50% Z motor current to reduce damage/intensity of impact  
 
; Step 1: do a rough contact-free measurement to get *kinda close* to bed
M98 P"0:/macros/config/configSZPnormal.g"

; set a safe Z trigger height to trigger when the bed is coming close but safely not touching. omit XY, these were defined in config.g!
; Z and P values are important here: These relate "Probe value [P] of 8850 relates to [Z] offset of 6mm".
; Get your probe's P value by moving to Z=6 manually after calibrating as described in configSZPnormal.g, and read the value reported in DWC then.
; if configSZPnormal.g is modified, these values must be updated too!

G31 K1 Z5 P15761            
G30 K1 S1                 ; execute Z homing to ensure printhead is close to bed


;; do nozzle wipe
M98 P"0:/macros/OPTION/SERVO_WIPE_SEQUENCE.G"

; Step 2: we should now be ~6mm above the bed. TIme to do the fine tuning!
M98 P"0:/macros/config/configSZPtouch.g"
G30 K1 S1                  ; execute contact probing and set Z
G91                        ; relative positioning
G1 Z5                      ; move up a bit
G90                        ; absolute positioning
 
; FInalization
M564 H1                     ; re-lock movement 
M913 Z100                   ; reset Z motor current to 100%  
M98 P"0:/macros/config/configSZPnormal.g"

;;=== old homez.g ===;;
;G91                     ; relative positioning
;G1 H2 Z5 F120     ; lift Z relative to current position

;M400 ; wait for moves to finish

;M561 ; clear any bed transform
;M290 R0 S0 ; clear babystepping

;check BL Touch
;if sensors.probes[0].value[0]=1000 ; if probe is in error state
;   echo "Probe in error state- resetting"
;   M280 P0 S160 ; reset BL Touch
;   G4 S0.5
;if state.gpOut[0].pwm=0.03
;   echo "Probe is already deployed - retracting"
;   M280 P0 S80 ; retract BLTouch
;   G4 S0.5

;if sensors.endstops[2].triggered
;   echo "Probe ia already triggered - resetting"
;   M280 P0 S160 ; reset BL Touch
;   G4 S0.5

;G90                     ; absolute positioning

; variabes set in Config.g

;M401

;G1 X{global.bedCenterX - sensors.probes[0].offsets[0] } Y{global.bedCenterY - sensors.probes[0].offsets[1]} F12000
;M400 ; wait for moves to finish
;G30               ; home Z by probing the bed
;if result !=0
;   abort "Print cancelled due to probe error"

;M400 ; wait for moves to finish

; Uncomment the following lines to lift Z after probing
;G91                ; relative positioning
;G1 H2 Z5 F100      ; lift Z relative to current position
;G90                ; absolute positioning
;G1 X{global.Bed_Center_X - sensors.probes[0].offsets[0] } Y{global.Bed_Center_Y - sensors.probes[0].offsets[1]} F12000
;reset speeds
;M402
;;=== old homez.g ===;;
M98 P"0:/macros/config/configMaxSpeed.g"
;M98 P"0:/macros/config/configOrcaSpeeds.g"