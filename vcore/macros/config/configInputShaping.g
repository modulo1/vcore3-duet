;;; Current input shaping settings
;; Pnnn : input shaper; "none", "zvd", "zvdd", "zvddd", "mzv", "ei2", "ei3" and "custom"
;; Fnnn Frequency of ringing to cancel in Hz
;; Snnn (optional) Damping factor of ringing to be cancelled, default 0.1.
;; Lnnn (optional) Minimum acceleration allowed, default 10mm/sec^2. Input shaping will not be applied if it requires the average acceleration to be reduced below this value.
;; Hnn:nn... Amplitudes of each impulse except the last, normally below 1.0. Only used with P"custom" parameter.
;; Tnn:nn Durations of each impulse except the last. Only used with P"custom" parameter.
;
; Since the input shaping plugin doesn't give you the M593 command it uses, you need to reconstruct it from scratch.
; So this: Input shaping 'mzv' at 25.0Hz damping factor 0.05, impulses 0.259 0.413 0.328 with delays (ms) 0.00 15.02 30.04
; becomes the following:
;M593 P"mzv" F25.0 S0.05 H0.259:0.413:0.328 T0.00:15.02:30.04



;;=== copy M593 output below ===;;

;Input shaping 'mzv' at 43.0Hz damping factor 0.05, impulses 0.259 0.413 0.328 with delays (ms) 0.00 8.73 17.46
M593 P"mzv" F43.0 S0.05 H0.259:0.413:0.329 T0.00:8.73:17.46
