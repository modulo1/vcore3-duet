;; check mesh.g and mesh.prusaslicer for setting on how to only create heightmap where printing

;=== configuration - bed - mesh compensation ===;
M376 H4                                                ;; fade mesh compensation at 3mm

;=== configuration - bed - z-probe offset ===;
;;set in config.g, but change here // old offset: G31 K0 P500 X-27.8 Y-12.0 Z1.55

;G31 K0 P500 X-23.34 Y-20.49                           ;; klickyPCB with stock switch
;G31 K0 X-27.8 Y-12.0 Z0.80                               ;; inductive probe
;G31 K0 P500 X-27 Y-12.0 Z0.750                              ;; rapido, inductive probe, 2510 fan mount
