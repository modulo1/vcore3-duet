;; simple macro to cool hotend by 30F
;; to avoid blobs in the bowden tube

;; uses cold retraction settings in filament
;; configuration

;; this macro returns hotend to printing temp
var ercfToolTemp = heat.heaters[1].current

if exists(param.C)
    if param.C = 0
        echo "Cooling down for filament change..."
        echo "Storing temperature: " ^ heat.heaters[1].current ^ "C"
        echo "Setting hotend standby temperature to " ^ {heat.coldExtrudeTemperature+10} ^"C"
        M568 S{heat.coldExtrudeTemperature+10} P{state.currentTool} 
        M568 A2 P{state.currentTool}
        M400

        echo "setting fan to 40%"
        M106 P1 S0.4

        echo "Waiting..."
        M116 P{state.currentTool}
        G4 S5



        M400
    elif param.C = 1
        echo "Restoring temperatures..."
        M586 S{var.ercfToolTemp} P{state.currentTool}
        M106 P1 S0
        M586 A2 P{state.currentTool}
        echo "Waiting..."
        M116 P{state.currentTool}
else
    echo "Missing param.C..."

M400