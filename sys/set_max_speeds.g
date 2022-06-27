;; set maximum instantaneous speed changes (mm/min)
;;; P1 =  jerk policy; allows jerk to be applied between any pair of moves 
M566 X1200.00 Y1200.00 Z12.00 E300 P1
;; set maximum speeds (mm/min)                                              
M203 X18000.00 Y18000.00 Z300.00 E7200.00
;; set accelerations (mm/s^2)                                                                               
M201 X2500.00 Y2500.00 Z200.00 E10000

M204 P500 T2000
