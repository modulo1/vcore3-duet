if !exists(global.RunDaemon)
	global RunDaemon = true 

if !exists(global.BedPreheatTemp)  
	global BedPreheatTemp = 60
	
if !exists(global.Cancelled)  ; global variable for exiting out of loops
	global Cancelled = false 

if !exists(global.filamentDistance)
	global filamentDistance = 0

if !exists(global.filamentFeedSpeed)
	global filamentFeedSpeed = 180

if !exists(global.filamentRetractSpeed)
	global filamentRetractSpeed = 1800
