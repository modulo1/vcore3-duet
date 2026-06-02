; *** FlowTestGenerator.js (v0.4.6) by iFallUpHill
; *** https://github.com/iFallUpHill/flow-calculator
; *** Based on CNCKitchen's ExtrusionSystemBenchmark by Stefan Hermann
; *** https://github.com/CNCKitchen/ExtrusionSystemBenchmark

;####### Settings
; bedWidth = 300
; bedLength = 300
; bedMargin = 10
; safeZPark = 10
; filamentDiameter = 1.75
; travelSpeed = 350
; dwellTime = 20
; bedTemp = 60
; fanSpeed = 30
; primeLength = 25
; primeAmount = 20
; primeSpeed = 5
; wipeLength = 15
; retractionDistance = 0.5
; retractionSpeed = 40
; blobHeight = 10
; extrusionAmount = 200
; direction = 1
; flowSpacing = 50
; tempSpacing = 38
; flowStart = 8
; flowOffset = 2
; flowSteps = 4
; flowEnd = 14
; tempStart = 200
; tempOffset = 20
; tempSteps = 3
; tempEnd = 240

;####### Start Gcode
M104 S200 ; Set Nozzle Temperature
M140 S60 ; Set Bed Temperature
G90 ; Absolute positioning
G0 Z10 ; Lift nozzle
G21 ; unit in mm
G92 E0 ; reset extruder
M83 ; set extruder to relative mode
M190 S60 ; Wait for Bed Temperature
M106 S76.5 ; Set Fan Speed
; M203 I0.1 ; Uncomment for Duet/RRF (slow z-moves)
; PRINT_START
; PRINT_START EXTRUDER=200 BED=60

; [SAFETY] Force Relative Extrusion
M83 ; set extruder to relative mode

;####### 200°C
G4 S0; Dwell
M109 S200

;####### 200°C // 8mm3/s
M117 200C // 8mm3/s
G0 X10 Y10 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X35 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X50 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F9.98 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X10 Y10 F21000
G92 E0 ; Reset Extruder

;####### 200°C // 10mm3/s
M117 200C // 10mm3/s
G0 X10 Y60 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X35 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X50 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F12.47 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X10 Y60 F21000
G92 E0 ; Reset Extruder

;####### 200°C // 12mm3/s
M117 200C // 12mm3/s
G0 X10 Y110 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X35 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X50 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F14.97 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X10 Y110 F21000
G92 E0 ; Reset Extruder

;####### 200°C // 14mm3/s
M117 200C // 14mm3/s
G0 X10 Y160 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X35 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X50 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F17.46 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X10 Y160 F21000
G92 E0 ; Reset Extruder

;####### 220°C
G4 S0; Dwell
M109 S220

;####### 220°C // 8mm3/s
M117 220C // 8mm3/s
G0 X88 Y10 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X113 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X128 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F9.98 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X88 Y10 F21000
G92 E0 ; Reset Extruder

;####### 220°C // 10mm3/s
M117 220C // 10mm3/s
G0 X88 Y60 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X113 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X128 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F12.47 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X88 Y60 F21000
G92 E0 ; Reset Extruder

;####### 220°C // 12mm3/s
M117 220C // 12mm3/s
G0 X88 Y110 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X113 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X128 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F14.97 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X88 Y110 F21000
G92 E0 ; Reset Extruder

;####### 220°C // 14mm3/s
M117 220C // 14mm3/s
G0 X88 Y160 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X113 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X128 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F17.46 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X88 Y160 F21000
G92 E0 ; Reset Extruder

;####### 240°C
G4 S0; Dwell
M109 S240

;####### 240°C // 8mm3/s
M117 240C // 8mm3/s
G0 X166 Y10 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X191 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X206 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F9.98 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X166 Y10 F21000
G92 E0 ; Reset Extruder

;####### 240°C // 10mm3/s
M117 240C // 10mm3/s
G0 X166 Y60 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X191 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X206 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F12.47 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X166 Y60 F21000
G92 E0 ; Reset Extruder

;####### 240°C // 12mm3/s
M117 240C // 12mm3/s
G0 X166 Y110 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X191 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X206 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F14.97 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X166 Y110 F21000
G92 E0 ; Reset Extruder

;####### 240°C // 14mm3/s
M117 240C // 14mm3/s
G0 X166 Y160 Z15.5 F21000
G4 S20 ; Dwell
G0 Z0.3 ; Drop down
G1 X191 E20 F300 ; Prime
G1 E-0.5 F2400 ; Retract
G0 X206 F21000 ; Wipe
G0 Z0.5 ; Lift
G1 E0.5 F2400 ; Undo Retract
G1 Z10.5 E200 F17.46 ; Extrude
G1 E-0.5 F2400 ; Retract
G0 Z15.5; Lift
G0 X166 Y160 F21000
G92 E0 ; Reset Extruder

;####### End Gcode
G4 ; Wait for buffer to clear
G0 X290 Y290 ; Move to Corner
M104 S0 T0 ; Turn Off Hotend
M140 S0 ; Turn Off Bed
M84 ; Disable Steppers
; PRINT_END