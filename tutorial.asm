; This is a program used in the ECE/CS 252
; PennSim tutorial.

	.ORIG x0200
START   
	NOT R3, R5
	ADD R3, R3, #1
	ADD R3, R3, R7

	BR START           ; repeat forever

	.END
        