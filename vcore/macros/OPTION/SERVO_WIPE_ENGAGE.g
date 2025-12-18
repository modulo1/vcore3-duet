M400
if move.axes[2].userPosition < 25.00
   abort "potential crash; minimum Z=25" 
else
   M280 P1 S55                    ;; move wiper arm over bed
   M400                           ;; wait for moves to finish
