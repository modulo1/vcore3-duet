
if exists(param.W)
    if param.W = 1 
        if move.axes[2].machinePosition < 25.00
            abort "potential crash; minimum Z=25"
        else
            M280 P1 S55                    ;; move wiper arm over bed
            M400                           ;; wait for moves to finish

    elif param.W = 0
        M280 P1 S120                           ;; make sure wiper arm isn't over bed
        M400                                  ;; wait for move to finish
else
    echo "Missing param.W"
    