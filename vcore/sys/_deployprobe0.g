; The deploy command for Z when using a dockable probe
if sensors.probes[0].value[0] != 0
    G1 X48.200 Y2.000 F999999 ; Move tool in front of dock
    G1 X18.200 Y2.000 F999999 ; Move tool in position where probe is mounted
    G1 X48.200 Y2.000 F999999 ; Move tool in front of dock
    M400 S1
if sensors.probes[0].value[0] != 0
   abort "Error probe not attached - aborting"
