;; set maximum instantaneous speed changes (mm/min)
;;; P1 =  jerk policy; allows jerk to be applied between any pair of moves 
M205 X20.00 Y20.00 Z0.2 E5.0 			; my current settings

;; set maximum speeds (mm/min)                                              
M203 X24000.00 Y24000.00 Z1200.00 E7200.00   ; my current settings

;; set accelerations (mm/s^2)
M201 X5000.00 Y5000.00 Z200.00 E10000 ; my current settings

; set printing and travel acceleration
M204 P1000 T5000

M906 X1600 Y1600 Z1600                                           ; set motor currents and motor idle factor in per cent
