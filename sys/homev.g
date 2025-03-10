M564 H0 S1
echo "ERCF configured - homing selector"
if global.ercfSelectorLoaded == global.ercfSelectorEngaged 
    G1 H1 V-9999 F1000
    G1 V5
    G1 H1 V-10 F150
    G1 V{global.ercfSelectorOffset}
    G92 V0
else
    echo "Error - servo engaged or retract filament from selector"
