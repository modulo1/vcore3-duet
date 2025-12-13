; The retract command for Z when using a dockable probe
if sensors.probes[0].value[0] != 1000
    G90
    G1 X48.200 Y2.000 F999999 ; Move tool in front of dock
    M400
    G1 X18.200 Y2.000 F999999 ; Move tool in position where probe is mounted
    G1 X18.200 Y41.400 F999999 ; Move tool to detach probe
    G1 X155 Y150 F999999 ; Move tool in front of dock
    M400
if sensors.probes[0].value[0] != 1000
    abort "Error probe not docked - aborting"
