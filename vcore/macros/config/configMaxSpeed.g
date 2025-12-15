;=== configuration - drive - current and idle factor ===;
M906 X1600 Y1600 Z1600 T30 I30                                                         ;; set motor currents and motor idle factor in per cent, December 2023
M913 X100 Y100 Z100                                                                    ;; ensure motors are at 100% current after homing

;=== configuration - drive - speed ===;
M203 X18000.00 Y18000.00 Z600.00                                                       ;; set maximum speeds (mm/min)


;=== configuration - drive - jerk ===;
M566 X900.00 Y900.00 Z150.00 P1                                                        ;; Set allowable instantaneous speed change in mm/min
M205 X5 Y5                                                                             ;; Set max instantaneous speed change in mm/sec

;=== configuration - drive - acceleration ===;
M201 X5000.00 Y5000.00 Z1000.00                                                        ;; set accelerations (mm/s^2
M201.1 X1000.00 Y1000.0 Z500.00

M204 P3000 T5000                                                                       ;; Set printing and travel acceleration (mm/s^2)
