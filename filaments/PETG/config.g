;; Set retraction settings for PLA filament
;;; Snnn = positive length to retract, in mm
;;; Fnnn = retraction feedrate, in mm/min
;;; Znnn = additional zlift/hop // using ventermech leadscrew decouplers, your Znnn may be different, or unecessary
M207 S1.5 F7200 Z0.3   

;; set pressure advance for PLA filament
;;; you can set this value here, or in the slicer
;;; i've found that PA value is pretty consistent across filament types
;;; this is especially true if you're getting your filament from the same mfr.
;;; changing it can be done easily from within DWC
M572 D0 S0.12
