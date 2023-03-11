;; check mesh.g for setting on how to only create heightmap where printing
;; in makes the following heightmaps obsolete
;G29 S1 P"heightmap_fulament.csv"    ; load heightmap_fulament.csv, or
;G29 S1 P"heightmap_fystec.csv"		 ; load heightmap_fystec.csv, or
;G29 S1 P"heightmap_ratrig.csv"		 ; load heightmap_ratrig.csv, or
;G29 S2	   ; ... don't

;; bed mesh fade
;;; Hnnn = height at which bed mesh transformation is no longer applied
;M376 H3

;z-probe parameters. set in config.g, but change here // old offset: G31 K0 P500 X-27.8 Y-12.0 Z1.55
;X-30 Y-15
;X-29.8 Y-13.5
;;;fystec sheet
;G31 K0 P500 X-30 Y-15 Z1.55

;;; fula-flex 2.0
;G31 K0 P500 X-29.8 Y-13.5 Z0.975 ; textured
G31 K0 P500 X-29.8 Y-13.5 Z0.95 ; textured
;G31 K0 P500 X-29.8 Y-13.5 Z0.575 ; old fulaflex, smooth, 0.4n
;G31 K0 P500 X-29.8 Y-13.5 Z0.635 ; new fulaflex, smooth, 0.4n

;;; ratrig sheet
;G31 K0 P500 X-30 Y-15 Z0.725 ; smooth, 0.4n, rtatrig plate
;G31 K0 P500 X-30 Y-15 Z1.20
