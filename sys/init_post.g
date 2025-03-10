;;;;===== global variables for preheating, review, extract, and extrapolate for filament load/preheat macros);;;;
; extrusion
if !exists(global.loadedFilament) || global.loadedFilament=null; global variable to hold filament name
    global loadedFilament="No_Filament" ; create a filament variable
G4 P10

if move.extruders[state.currentTool].filament=""
    echo "No filament loaded.  Cold extrude & retract set to defaults"
    M302 S190 R110 ; Allow extrusion starting from 190°C and retractions already from 110°C (defaults)
    set global.loadedFilament="No_Filament"
else
    set global.loadedFilament=move.extruders[state.currentTool].filament ; set the variable to the currently loaded filament
    echo "Loading config for " ^ global.loadedFilament ^ " filament"
    M703 ; if a filament is loaded, set all the heats and speeds for it by loading config.g
G4 P10
