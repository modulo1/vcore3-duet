; The deploy command for Z when using a dockable probe
if sensors.probes[0].value[0] != 0
    ;var originX = {move.axes[0].userPosition} ; Store the X position before grabbing the probe.
    ;var originY = {move.axes[1].userPosition} ; Store the Y position before grabbing the probe.
    G1 X39.200 Y0.000 F999999 ; Move tool in front of dock
    G1 X19.200 Y0.000 F6000 ; Move tool in position where probe is mounted
    G1 X39.200 Y0.000 F6000 ; Move tool in front of dock
    ;if var.originX > 39.200 || var.originY > 0.000
        ; Move the toolhead back to the position we came from
    ;    G1 X{var.originX} Y{var.originY} F999999
    M400
if sensors.probes[0].value[0] != 0
   abort "Error probe not attached - aborting"
