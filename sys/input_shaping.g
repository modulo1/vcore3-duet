;;; Current input shaping settings
;; Pnnn : input shaper; "none", "zvd", "zvdd", "zvddd", "mzv", "ei2", "ei3" and "custom"
;; Fnnn Frequency of ringing to cancel in Hz
;; Snnn (optional) Damping factor of ringing to be cancelled, default 0.1.
;; Lnnn (optional) Minimum acceleration allowed, default 10mm/sec^2. Input shaping will not be applied if it requires the average acceleration to be reduced below this value.
;; Hnn:nn... Amplitudes of each impulse except the last, normally below 1.0. Only used with P"custom" parameter.
;; Tnn:nn Durations of each impulse except the last. Only used with P"custom" parameter.

;M593 P"zvdd" F38.0 S0.14 L10 H:0.226:0.661:0.940 T13.29
