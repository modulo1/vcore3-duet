if !exists(global.runDaemon)
    global runDaemon = false

if !exists(global.bedPreheatTemp)
    global bedPreheatTemp = 60

if !exists(global.cancelled)  ; global variable for exiting out of loops
    global cancelled = false

if !exists(global.filamentDistance)
    global filamentDistance = 0

if !exists(global.filamentFeedSpeed)
    global filamentFeedSpeed = 1800

if !exists(global.filamentRetractSpeed)
    global filamentRetractSpeed = 3600

if !exists(global.filamentDistance)
    global filamentDistance = 0 ; global for use to allow filament to feed for set distance after sensor trips
else
    set global.filamentDistance = 0

