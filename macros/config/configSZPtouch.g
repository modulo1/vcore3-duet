;; move to Z=5 with G1 Z5
;; run M558.2 K1 S-1
;; replace Snnn and Rnnn below

M558.2 K1 S13 R216240

;; V=Threshold. Start with V0.1 and increase until it works reliably without misdetections.
;; H=Nozzle height (mm) to be assumed when touch is detected, normally negative
;;    closer to zero = closer to the bed (I think...)

M558.3 K1 S1 V3.5 F200 H-0.14