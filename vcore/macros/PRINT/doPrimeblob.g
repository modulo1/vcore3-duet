; prime blob macro, inspired by RatOS prime blob macro
;
; --- parameters: 
;     D for tool to prime
;
; --- usage:
; 
;   call in start.g like this:
;
;   while counter <= limits.tools
;       M98 P"prime-blob.g" D{counter}
;
;   this should prime blob a single tool as normal,
;   and multiple tools in staggered positions so the prime blobs
;   don't interfere. If you have a single tool machine, you can 
;   simply call
; 
;    M98 P"prime-blob.g" D0
;
; --- variables:
;
; stagger prime blobs for multiple tools, moving from the outside in.
;
;var blob_pos_x = {move.axes[0].max-5-(param.D*10)}  
var blob_pos_x = {move.axes[0].min+10-(param.D*10)} 
;echo "blob_pos_x: " ^ var.blob_pos_x 
;
; place prime blobs close to the front edge
;
;var blob_pos_y = {move.axes[1].min+5}
var blob_pos_y = {move.axes[1].min+10}
;
; speed limits
;
var blob_speed = 150                                              ; extrusion speed for the blob 
var wipe_speed = 200                                              ; move speed for the diagonal wipe
var lift_speed = 3000                                              ; z lift speed (usually limited by machine definition)
var travel_speed = 6000                                            ; travel move speed
; 
; --- sanity checks
;
; check that tool passed is defined

if {param.D} > limits.tools
   abort "tool " ^ param.D ^ " not defined, aborting prime blob"

; ensure tool is active and heated

if tools[param.D].state != "active"
   echo "tool " ^ param.D " not active, trying to activate and heat"
   T{param.D} P0              ; make sure tool is selected and active
   M116 P{param.D}          ; wait for active tool temp
   G4 P300                  ; empty queue and wait 300 msec
; 
;if heat.heaters[{param.D+1}].current < heat.coldExtrudeTemperature ; heater 0 is bed, this assumes that heaters 1-n are assigned to tools
;    abort "tool " ^ param.D ^ " not up to temp, aborting prime blob"
   
; --- start prime blob procedure

echo "Priming tool " ^ param.D ^ " with prime blob"

G90                                                                ; set absolute positioning
M83                                                                ; set relative extrusion

; assume position

M98 P"0:/macros/print/movePrimeblob.g"

;G1 Z5 F{var.lift_speed}                                            ; lift Z
;G1 X{var.blob_pos_x} Y{var.blob_pos_y} Z0.5 F{var.travel_speed}    ; move to blob position in the lower left corner

; prime blob
G1 F600 E20                                                        ; move filament back into meltzone
G1 F{var.blob_speed} E30                                           ; extrude a blob
M106 S0.4                                                          ; 40% fan
G1 Z5 F{var.wipe_speed/2} E5                                       ; Move the extruder up by 5mm while extruding, breaks away from blob

; wipe 

G1 F{var.wipe_speed} Y{move.axes[1].min+25} E1                     ; Move to wipe position, but keep extruding so the wipe is attached to blob
G1 F{var.wipe_speed} Y{move.axes[1].min+45} Z0.2 E2                ; Go down diagonally while extruding
M106 S0                                                            ; disable fan
G1 F{var.wipe_speed} Y{move.axes[1].min+50} Z0.2 E0.8              ; small wipe line
G1 F{var.travel_speed} Y{move.axes[1].min+100}                     ; break-away wipe
M400

echo "Prime blob finished; beginning print."