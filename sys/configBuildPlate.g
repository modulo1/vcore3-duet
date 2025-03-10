;; check mesh.g and mesh.prusaslicer for setting on how to only create heightmap where printing

;=== configuration - bed - mesh compensation ===;
M376 H10                                                ;; fade mesh compensation at 3mm

;=== configuration - bed - z-probe offset ===;
;;set in config.g, but change here // old offset: G31 K0 P500 X-27.8 Y-12.0 Z1.55

;=== superlight ===;
G31 K0 X-27 Y-12.0 Z1.35                                 ;; inductive probe
G31 K1 X0.0 Y15.00 Z2.00                                 ;; beacon duct 1
