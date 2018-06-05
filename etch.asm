;ECE 252 HW12 - WILLIAM SHU - 9073748874
;

  .orig x3000
ETCH_A_SKETCH

   TRAP x30              ; init display

   AND  R4, R4, #0	 ; plot first pixel
   AND  R5, R5, #0
   JSR  MoveP

   ; put specific values into registers so
   ; we can see if subroutines modify them...
   LD   R0, INITR0
   ADD  R1, R0, #1
   ADD  R2, R0, #2
   ADD  R3, R0, #3
   ADD  R4, R0, #4
   ADD  R5, R0, #5
   ADD  R6, R0, #6
   ADD  R7, R0, #7

ETCH_LOOP
   JSR   GetMove          ; get next move value
   JSR   MoveP            ; paint next pixel
   BR    ETCH_LOOP        ; repeat forever

INITR0  .FILL xF000
; global variables of current X,Y position
Xpos    .FILL  32        
Ypos    .FILL  32


; MoveP
;
; Draws single black (color = 0) pixel on 
; graphical display based on moving X,Y 
; from current position stored in Xpos, Ypos.
; Updates Xpos, Ypos with new current position,
; keeping Xpos and Ypos in the range 0-63.
;
; Assumes: R4 - X distance to move
;          R5 - Y distance to move
; Returns: Nothing
;
MoveP
 ; PUT YOUR MoveP SUBROUTINE CODE/DATA BELOW HERE
ST R1, MoveP_R1		; context save
ST R2, MoveP_R2
ST R3, MoveP_R3
ST R7, MoveP_R7


LD R1, Xpos		; load X, Y position to R1, R2
LD R2, Ypos
LD R3, MoveP_Mask	; load mask

ADD R1, R1, R4		; update X position
ADD R2, R2, R5		; update Y position

AND R4, R1, R3		; make X, Y position in range with mask
AND R5, R2, R3

ST R4, Xpos		; store X, Y position
ST R5, Ypos


TRAP x31			; print the point

MoveP_Back
LD R1, MoveP_R1		; context restore
LD R2, MoveP_R2
LD R3, MoveP_R3T
LD R4, Value_R4
LD R5, Value_R5
LD R7, MoveP_R7

RET


MoveP_R1	.BLKW 1
MoveP_R2	.BLKW 1
MoveP_R3	.BLKW 1
MoveP_R7	.BLKW 1
MoveP_Mask	.FILL #63

 ; PUT YOUR MoveP SUBROUTINE CODE/DATA ABOVE HERE


; GetMove
;
; Waits for a single char from the keyboard, 
; echoes that character to the console,
; and returns XY movement corresponding
; to that character.
; Valid characters are 'A' (left), 'D' (right),
; 'W' (up) and 'X' (down). For any other character,
; return X,Y = 0,0
;
; Assumes: None
; Returns: R4 - X distance to move
;          R5 - Y distance to move
;
GetMove
 ; PUT YOUR GetMove SUBROUTINE CODE/DATA BELOW HERE

ST R0, GetMove_R0	; context save
ST R1, GetMove_R1
ST R2, GetMove_R2
ST R4, Value_R4
ST R5, Value_R5
ST R7, GetMove_R7


TRAP x20			; get character from keyboard
TRAP x21			; echoes the character back to console

AND R4, R4, 0
AND R5, R5, 0		; set X,Y value to 0


LD R1, A_Value		; load negated A value to R1
ADD R2, R1, R0		; check if the character is A
BRz	is_A			; if value is 0, it is A, then go branchA

				; if not, keep checking other situation
LD R1, D_Value		; load negated D value to R1
ADD R2, R1, R0		; check if the character is D
BRz	is_D			; if value is 0, it is D, then go branchD

				; if not, keep checking other situation
LD R1, W_Value		; load negated W value to R1
ADD R2, R1, R0		; check if the character is W
BRz	is_W			; if value is 0, it is W, then go branchW

				; if not, keep checking other situation
LD R1, X_Value		; load negated X value to R1
ADD R2, R1, R0		; check if the character is X
BRz	is_X			; if value is 0, it is X, then go branchX
BR	GetMove_Back	; if not, back to main program with X,Y=0,0

; this branch is designed to modify the X value
is_A
ADD R4, R4, #-1		; decrease R4 by 1
BR GetMove_Back

; this branch is designed to modify the X value
is_D
ADD R4, R4, #1		; increase R5 by 1
BR GetMove_Back

; this branch is designed to modify the Y value
is_W
ADD R5, R5, #-1		; make R5 upward by 1
BR GetMove_Back

; this branch is designed to modify the Y value
is_X
ADD R5, R5, #1		; shift R5 downward by 1
BR GetMove_Back

; this branch is designed to restore the context 
; and return to the main program
GetMove_Back
LD R0, GetMove_R0	; context restore
LD R1, GetMove_R1
LD R2, GetMove_R2
LD R7, GetMove_R7
RET				


GetMove_R0	.BLKW 1
GetMove_R1	.BLKW 1
GetMove_R2	.BLKW 1
GetMove_R7	.BLKW 1
Value_R4	.BLKW 1
Value_R5	.BLKW 1
A_Value	.FILL #-65
D_Value	.FILL #-68
W_Value	.FILL #-87
X_Value	.FILL #-88

 ; PUT YOUR GetMove SUBROUTINE CODE/DATA ABOVE HERE



.end