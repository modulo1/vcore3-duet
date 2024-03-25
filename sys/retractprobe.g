; The retract command for Z when using a dockable probe
if sensors.probes[0].value[0] != 1000
    G90
    G1 X39.200 Y0.000 F999999 ; Move tool in front of dock
    M400
    G1 X19.200 Y0.000 F6000 ; Move tool in position where probe is mounted
    G1 X19.200 Y40.000 F6000 ; Move tool to detach probe
    M400
if sensors.probes[0].value[0] != 1000
    abort "Error probe not docked - aborting"
