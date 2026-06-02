var blob_pos_x = {move.axes[0].max-5}  
var blob_pos_y = {move.axes[1].min+10}

var lift_speed = 3000                                              ; z lift speed (usually limited by machine definition)
var travel_speed = 6000                                            ; travel move speed


;G1 Z5 F{var.lift_speed}                                            ; lift Z
G1 X{var.blob_pos_x} Y{var.blob_pos_y} Z0.5 F{var.travel_speed}    ; move to blob position in the lower left corner

