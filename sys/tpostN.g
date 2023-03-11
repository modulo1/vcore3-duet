M710
M711
G10 P{state.currentTool} S{tools[state.previousTool].active[0]} R0                                 ; set initial tool 0 active and standby temperatures to 0C
G10 P{state.previousTool} S0 R0		; set previous tool temp to 0
M116 P{state.currentTool}
