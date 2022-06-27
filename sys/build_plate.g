;G29 S1     ; load heightmap
G29 S2	   ; ... or don't

;; bed mesh fade
;;; Hnnn = height at which bed mesh transformation is no longer applied
;M376 H2

;z-probe parameters. set in config.g, but change here
;fystec sheet
G31 K0 P500 X-27.8 Y-12.0 Z0.98
;;; fula-flex 2.0
;G31 K0 P500 X-27.8 Y-12.0 Z1.0
;;; ratrig sheet
;G31 K0 P500 X-27.8 Y-12.0 Z1.20
