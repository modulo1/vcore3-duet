;SYS_STARTUP.g
;; run this after applying ERCF configuration

;variables
;set global.ercfPulseCount = 0
;var ercfLastCount = global.ercfPulseCount

M584 P5
M291 R"ERCFv2 starting up..." P"ERCFv2 configuration loaded...; Ensure filament cutter and filament gate are clear before proceeding." S3 A1
M584 P4


G4 S2


;; enable servos
M98 P"0:/sys/ERCFv2/sys/SYS_INIT_SERVO.g"


G4 S2


;; home ERCF axis'
if !move.axes[3].homed
    G28 V
else
    M98 P"0:/sys/homea.g"


;; deselects tool
T-1 P0
M400