if !exists(global.RunDaemon)
	global RunDaemon = false  
else
	set global.RunDaemon = true 

if !exists(global.Cancelled)  ; global variable for exiting out of loops
	global Cancelled = false  
else
	set global.Cancelled = false 

if !exists(global.filamentDistance)
	global filamentDistance = 0 ; global for use to allow filament to feed for set distance after sensor trips 
else
	set global.filamentDistance = 0

if !exists(global.filamentFeedSpeed)
	global filamentFeedSpeed = 180 ; global to set the feed speed used in filament changes - adjusted per filament in filament config.c 
else
	set global.filamentFeedSpeed = 180

if !exists(global.filamentRetractSpeed)
	global filamentRetractSpeed = 1800 ; global to set the retract speed used in filament changes - adjusted per filament in filament config.c 
else
	set global.filamentRetractSpeed = 1800
