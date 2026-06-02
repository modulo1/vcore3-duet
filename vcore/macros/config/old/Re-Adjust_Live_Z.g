M290 R0 S0                             ;; reset baby stepping
M98 P"0:/sys/configBuildPlate.g"
G29 S2
G28 Z
G32
G29
G29 S1
G1 X155 Y150 Z0.2
