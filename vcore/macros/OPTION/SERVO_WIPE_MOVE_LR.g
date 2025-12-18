var end_pos_x = 250
var end_pos_y = 250

var start_pos_x = 250
var start_pos_y = 290

var wipe_speed = 12000

G1 X{var.start_pos_x - 10} Y{var.start_pos_y - 10} F{var.wipe_speed / 2}
G1 X{var.end_pos_x + 10} Y{var.end_pos_y + 10} F{var.wipe_speed / 2}

G1 X{var.end_pos_x - 10} Y{var.end_pos_y + 10} F{var.wipe_speed / 2}
G1 X{var.start_pos_x + 10} Y{var.start_pos_y} F{var.wipe_speed / 2}

G1 X{var.start_pos_x - 10} Y{var.start_pos_y - 10} F{var.wipe_speed / 3}
G1 X{var.end_pos_x + 10} Y{var.end_pos_y + 10} F{var.wipe_speed / 3}

G1 X{var.end_pos_x - 10} Y{var.end_pos_y + 10} F{var.wipe_speed / 3}
G1 X{var.start_pos_x + 10} Y{var.start_pos_y} F{var.wipe_speed / 3}