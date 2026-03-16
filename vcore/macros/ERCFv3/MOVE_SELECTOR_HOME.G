;ERCF_SELECTOR_HOME.g


M564 H0 S1

M584 P5

M400

if global.ercfServoEngaged == 0
    G1 H1 V-9999 F10000
    G1 V5
    G1 H1 V-10 F1000
    G1 V{global.ercfSelectorOffset}
    G92 V0
    set global.ercfCurrentSelector = 0
    echo "Selector homed.  Currently at ", {tools[global.ercfCurrentSelector].name}
    
else
    echo "Error: filament loaded in selector.  unload before continuing"

M584 P4
M400