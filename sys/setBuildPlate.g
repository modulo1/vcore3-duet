;; check mesh.g and mesh.prusaslicer for setting on how to only create heightmap where printing

;=== configuration - bed - mesh compensation ===;
;M376 H3                                                ;; fade mesh compensation at 3mm

;=== configuration - bed - z-probe offset ===;
;;set in config.g, but change here // old offset: G31 K0 P500 X-27.8 Y-12.0 Z1.55
G31 P500 X-23.34 Y-20.49 Z1.937                         ;; klickyPCB with stock switch
;G31 P500 X-27.70 Y-20.49 Z5.57                         ;; klickyPCB with plunger switch
