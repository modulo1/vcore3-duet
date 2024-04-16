;=== configuration - drive - current and idle factor ===;
M906 X1600 Y1600 Z1600 I30                                                            ;; set motor currents and motor idle factor in per cent, December 2023
M913 X80 Y80 Z80                                                                      ;; set X Y Z motors to 80% of their normal current

;=== configuration - drive - jerk ===;
;M566 X400.00 Y400.00 Z6.00 E3600 P1                                                  ;; ratrig default
;M205 X20.00 Y20.00 Z0.2 E5.0 	                                                      ;; my current settings, December 2023
M205 X3.3 Y3.3 Z0.2 P1                                                              ;; set maximum instantaneous speed changes (mm/min) and jerk policy 

;=== configuration - drive - speed ===;                                             
;M203 X10800.00 Y10800.00 Z1000.00 E7200                                              ;; ratrig default
;M203 X24000.00 Y24000.00 Z1200.00 E7200.00                                           ;; my current settings, December 2023
M203 X1200.00 Y1200.00 Z600.00                                                      ;; set maximum speeds (mm/min) 

;=== configuration - drive - acceleration ===;
;M201 X3000.00 Y3000.00 Z100.00 E10000                                                ;; ratrig default
;M201 X5000.00 Y5000.00 Z200.00 E10000                                                ;; my current settings, December 2023
;M201 X5000.00 Y5000.00 Z100.00 E10000.00                                             ;; set accelerations (mm/s^2), vz-hextrudort
M201 X400.00 Y400.00 Z60.00                                                        ;; set accelerations (mm/s^2), orbiter v2
