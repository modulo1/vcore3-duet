;;; Current input shaping settings
;; Pnnn : input shaper; "none", "zvd", "zvdd", "zvddd", "mzv", "ei2", "ei3" and "custom"
;; Fnnn Frequency of ringing to cancel in Hz
;; Snnn (optional) Damping factor of ringing to be cancelled, default 0.1.
;; Lnnn (optional) Minimum acceleration allowed, default 10mm/sec^2. Input shaping will not be applied if it requires the average acceleration to be reduced below this value.
;; Hnn:nn... Amplitudes of each impulse except the last, normally below 1.0. Only used with P"custom" parameter.
;; Tnn:nn Durations of each impulse except the last. Only used with P"custom" parameter.
;
; Since the input shaping plugin doesn't give you the M593 command it uses, you need to reconstruct it from scratch.
; So this: Input shaping 'zvd' at 31.0Hz damping factor 0.15, min. acceleration 10.0, impulses 0.381 0.853 with durations (ms) 16.31 16.31
; Becomes the below
M593 P"zvd" F31.0 S0.15 L10 H:0.381:0.853 T16.31:16.31
