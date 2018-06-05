; HW08 -- William Shu -- 9073748874
;
;
     .ORIG x0200
START
     LEA  R0, HERE      ; get address of element 4

; Your code goes BELOW here

LDR R1, R0, #-4; Set the value of R1=element 0.
LDR R2, R0, #1; Set the value of R2=element 5.
STR R2, R0, #-4; Store the value of R2 to element 0.
STR R1, R0, #1; Store the value of R1 to element 5.

LDR R1, R0, #-3; Set the value of R1=element 1.
LDR R2, R0, #0; Set the value of R2=element 4.
STR R2, R0, #-3; Store the value of R2 to element 1.
STR R1, R0, #0; Store the value of R1 to element 4.

LDR R1, R0, #-2; Set the value of R1=element 2.
LDR R2, R0, #-1; Set the value of R2=element 3.
STR R2, R0, #-2; Store the value of R2 to element 2.
STR R1, R0, #-1; Store the value of R1 to element 3.


  
; Your code goes ABOVE here

     BR   START          ; repeat forever

; data for HW08 program
         .FILL xA111     ; data element 0
         .FILL xB111     ; data element 1
         .FILL xC111     ; data element 2
         .FILL xD111     ; data element 3
HERE     .FILL xE111     ; data element 4
         .FILL xF111     ; data element 5

     .END
