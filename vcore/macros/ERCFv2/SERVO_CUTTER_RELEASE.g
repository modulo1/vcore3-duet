;ERCF_SERVO_CUTTER_OPEN.g

if global.ercfSelectorLoaded = 0
    M280 P5 S175
    M400
else
    echo "Selector loaded.  Clear filament before releasing cutter."
;set global.ercfSelectorEngaged = 0