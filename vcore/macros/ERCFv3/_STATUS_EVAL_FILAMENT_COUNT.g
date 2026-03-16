echo "Current ERCF gate status:"

;var ercfLoadedCounter = 0
;var ercfUnloadedCounter = 0


while iterations < #{global.ercfLoadedGate}
   echo global.ercfLoadedGate[iterations] ? "Loaded" : "Unloaded"
