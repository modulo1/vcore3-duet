;=== configuration - drive - current and idle factor ===;
M906 X1600 Y1600 Z1600 I30                                                            ;; set motor currents and motor idle factor in per cent, December 2023
M913 X60 Y60 Z60                                                                      ;; set X Y Z motors to 80% of their normal current

;=== configuration - drive - jerk ===;
M566 X300.00 Y300.00 Z6.00 P1                                                ;; ratrig default
M205 X3 Y3 Z3 P1                                                              ;; set maximum instantaneous speed changes (mm/min) and jerk policy

;=== configuration - drive - speed ===;
M203 X1200.00 Y1200.00 Z800.00                                                      ;; set maximum speeds (mm/min)

;=== configuration - drive - acceleration ===;
M201 X500.00 Y500.00 Z50.00                                                        ;; set accelerations (mm/s^2), orbiter v2
