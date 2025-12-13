;; set Z=0 with sheet of paper
;; G92 Z0
;; move to Z=10 with G1 Z10

M558.3 K1 S0               ; S0 -> enter normal probing mode

;; run M558.2 K1 S-1
;; replace Snnn and Rnnn below

;M558.2 K1 S13 R214858
M558.2. K1 S14 R214191
