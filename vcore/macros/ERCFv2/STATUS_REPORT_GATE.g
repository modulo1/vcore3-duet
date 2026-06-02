echo "Current ERCF gate status:"

var ercfLoadedCounter = 0
var ercfUnloadedCounter = 0


while iterations < #{global.ercfGateLoad}
   if global.ercfGateLoad[iterations] = 0
      ;echo (tools[iterations].name) ^" is not loaded."
          set var.ercfUnloadedCounter = var.ercfUnloadedCounter + 1
   if global.ercfGateLoad[iterations] = 1 
      ;echo (tools[iterations].name) ^" is loaded."
          set var.ercfLoadedCounter = var.ercfLoadedCounter + 1

echo "total gates loaded - " ^ var.ercfLoadedCounter
echo "total gates unloaded - " ^ var.ercfUnloadedCounter

if var.ercfLoadedCounter > #job.file.filament
    echo "Loaded gates matches filament in job..."
else
    echo "Job requires more filament than loaded.  Aborting."
    
    