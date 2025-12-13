;;=== perform mesh compensation only where printing ===;;
;M98 P"0:/sys/configDefaultProbePoints.g" ; reset probe points again, just in case

;if (exists(param.A) && exists(param.B) && exists(param.C) && exists(param.D) && exists(param.N))
;    M557 X{max(move.compensation.probeGrid.mins[0],param.A),min(move.compensation.probeGrid.maxs[0],param.B)} Y{max(move.compensation.probeGrid.mins[1],param.C),min(move.compensation.probeGrid.maxs[1] ,param.D)} S{param.N}
;    if result != 0
;        abort "Invalid M557 parameters"

;G29 K0 S0

;=== SZP configuration ===;;
M98 P"0:/macros/config/configDefaultProbePoints.g" ; reset probe points again, just in case

G29 S2                       ; Disable mesh bed compensation

G28 Z                        ; Home Z

G1 X155 Y150 Z5

G1 Z6                        ; To avoid backlash move to point higher than start of calibration

M558.1 K1 S1.0               ; Calibrate probe

G4 S1

G1 Z6                        ; Move up at end of calibration

G29 S0 K1                    ; Scan bed and create mesh

;G1 X150 Y150 F10000
G1 X{global.bedCenterX - sensors.probes[1].offsets[0] } Y{global.bedCenterY - sensors.probes[1].offsets[1]} F12000
;G1 X{global.bedCenterX} Y{global.bedCenterY} F12000
;G1 X18.200 Y41.400 F999999   ; move back behind klicky dock