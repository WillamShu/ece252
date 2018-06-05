; HW08 -- William Shu -- 9073748874
;
;
     .ORIG x0200
START

NOT R3, R2
ADD R3, R3, #1
ADD R4, R1, R3
BRp STORER1
ADD R0, R2, 0
BR DONE
STORER1 ADD R0, R1, 0
DONE
  
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

