;=== configuration - drive - jerk ===;
;M205 X20.00 Y20.00 Z0.2 E5.0 	                                                      ;; my current settings, December 2023
M205 X5.00 Y5.00 Z0.4 E5.00 P1                                                        ;; set maximum instantaneous speed changes (mm/min) and jerk policy 

;=== configuration - drive - speed ===;                                             
;M203 X24000.00 Y24000.00 Z1200.00 E7200.00                                           ;; my current settings, December 2023
M203 X18000.00 Y18000.00 Z900.00 E7200.00                                             ;; set maximum speeds (mm/min) 

;=== configuration - drive - acceleration ===;
;M201 X5000.00 Y5000.00 Z200.00 E10000                                                ;; my current settings, December 2023
M201 X5000.00 Y5000.00 Z100.00 E10000.00                                              ;; set accelerations (mm/s^2)
M204 P2500 T5000                                                                      ;; Set printing and travel acceleration (mm/s^2)

;=== configuration - drive - current and idle factor ===;
M906 X1600 Y1600 Z1600 I30                                                            ;; set motor currents and motor idle factor in per cent, December 2023
