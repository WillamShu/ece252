;ECE 252 HW09 - WILLIAM SHU - 9073748874
;

	.orig x0200
START

; your code goes below here

; This code consider the situation that B could be negative.

; Initialize variables
LD R0, A  ;Assign the value A into R0
LD R1, B  ;Assign the value B into R1
LD R2, C  ;Assign the value C into R2

; If we consider the situation that B could be negative value.
; Firstly, we check B is positive of negative.
; If B is positive, then we keep substracting 2 from B.
; If B is negative, then we keep adding 2 to B.
; If the sign of the final value changed, that means B is odd.

ADD R3, R1, 0 ; Set R3 as the condition code check register.
BRz BLKD ; If R3 is zero, perform else situation.
BRn BLKE ; If R3 is negative, keep adding.

; If R3 is positive, keep substracting.
BLKB ADD R3, R3, #-2 
BRp BLKB ; keep substracting if it is positive
BRn BLKC ; negative means B is odd.

; zero means B is even.
BLKD ADD R2, R0, #-3 ; substract 3 from B
BR DONE

BLKE ADD R3, R3, #2 ; If B is negative, then keep adding 2 to B.
BRn BLKE ; If the result is still negative, repeat adding.
BRz BLKD ; If the result comes to zero, then B is even.

; If the result comes to positive, that means B is odd.
BLKC ADD R2, R0, R1 ; Add R0 and R1
BR DONE

; Store result.
DONE	ST R2, C

; your code goes above here

	BR START	; repeat forever for easier testing!

; variable definitions
A	.FILL #3
B	.FILL #15
C	.FILL #27
	.end
        