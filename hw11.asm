;ECE 252 HW11 - WILLIAM SHU - 9073748874
;

  .orig x0200

  ; first, put specific values into registers so
  ; we can check if subroutines modify them
  LD R0, INITR0
  ADD R1, R0, #1
  ADD R2, R0, #2
  ADD R3, R0, #3
  ADD R4, R0, #4
  ADD R5, R0, #5
  ADD R6, R0, #6
  ADD R7, R0, #7

  ; compute SoAD for first 2 elements of vectors 1 and 2
  LEA R1, Vector1
  LEA R2, Vector2
  AND R3, R3, #0
  ADD R3, R3, #2
  JSR SoAD

  ; compute SoAD for vectors 1 and 2
  LEA R1, Vector1
  LEA R2, Vector2
  AND R3, R3, #0
  ADD R3, R3, #4
  JSR SoAD

  ; compute SoAD for vectors 1 and 3
  LEA R1, Vector1
  LEA R2, Vector3
  AND R3, R3, #0
  ADD R3, R3, #4
  JSR SoAD

  ; compute SoAD for vectors 2 and 3
  LEA R1, Vector2
  LEA R2, Vector3
  AND R3, R3, #0
  ADD R3, R3, #4
  JSR SoAD

  ; compute SoAD for vectors 4 and 5
  LEA R1, Vector4
  LEA R2, Vector5
  LD  R3, LENGTH
  JSR SoAD

DONE
   BR DONE

; SoAD
;
; Compute the sum of absolute differences of two vectors
;
; Assumes: R1 = pointer to first vector
;          R2 = pointer to second vector
;          R3 = vector length
; Returns: R3 = sum of absolute differences
;
SoAD
; YOUR CODE/DATA GOES BELOW HERE

ST R4, SoAD_R4 ; context save
ST R5, SoAD_R5
ST R6, SoAD_R6
ST R7, SoAD_R7

AND R4, R4, 0 ; clear R4

SoAR1
ADD R3, R3, #-1 ; decrease the vector length
BRzp SoAR_BRC   ; if length is positive or zero, execute SoAR_BRC
ADD R3, R4, 0	; if not, R3 is now the result (R4)
LD R4 SoAD_R4	; context restore
LD R5 SoAD_R5
LD R6 SoAD_R6
LD R7 SoAD_R7

RET			; return to caller

; this branch suppose to load the first and second value to R5,R6
; and increse the pointer 

SoAR_BRC
LDR R5, R1, #0	; get first value from R5
LDR R6, R2, #0	; get second value from R6
ADD R1, R1, #1	; increment first vector pointer
ADD R2, R2, #1	; increment second vector pointer
JSR absdiff	; call absdiff
ADD R4 R4 R5	; load result (R5) into R4
BR SoAR1		; repeat SoAR1 to check if the program is over

SoAD_R4 .BLKW 1
SoAD_R5 .BLKW 1
SoAD_R6 .BLKW 1
SoAD_R7 .BLKW 1

; YOUR CODE/DATA GOES ABOVE HERE


; absdiff
;
; Computes absolute difference of two values
;
; Assumes: R5 = first value
;          R6 = second value
; Returns: R5 = absolute difference
;
absdiff
    NOT   R5, R5             ; negate first value
    ADD   R5, R5, #1
    ADD   R5, R5, R6         ; compute difference
    BRzp  absdiff_exit       ; done if positive
    NOT   R5, R5             ; otherwise negate
    ADD   R5, R5, #1
absdiff_exit
    RET


; data for test program

INITR0    .FILL xF000;
Vector1   .FILL 17
          .FILL -17
          .FILL -17
          .FILL 17
Vector2   .FILL -1
          .FILL 2
          .FILL -3
          .FILL 4
Vector3   .FILL 4
          .FILL 3
          .FILL -2
          .FILL -1
Vector4   .STRINGZ "42234567890123456789"
Vector5   .STRINGZ "89346534728934653472"
LENGTH    .FILL 20



   .end