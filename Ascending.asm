;Write ALP to arrange numbers in ascending order.

DATA SEGMENT
      MSG1 DB 0DH, 0AH, "ENTER A NUMBER : $"
      MSG2 DB 0AH, 0DH, "NUMBER IN ASCENDING ORDER IS: $"
      A    DB 10 DUP("$")
DATA ENDS

CODE SEGMENT
            ASSUME DS: DATA, CS:CODE
      START:MOV    AX, DATA
            MOV    DS, AX
            MOV    CX, 05H
            MOV    BX, 00H
    
      UP:   
            MOV    DX, OFFSET MSG1
            MOV    AH, 09H
            INT    21H
            MOV    AH, 01H
            INT    21H
            MOV    [A+BX], AL
            INC    BX
            DEC    CX
            JNZ    UP
            MOV    CX, 05H
      LOOP1:
            MOV    DX, 04H
            MOV    BX, 00H
      LOOP2:
            MOV    AL, [A+BX]
            CMP    AL, [A+BX+1]
            JGE    ABOVE
      CONT: 
            INC    BX
            DEC    DX
            JNZ    LOOP2
            DEC    CX
            JNZ    LOOP1
            JMP    LAST
    
      ABOVE:
            MOV    AL, [A+BX+1]
            XCHG   [A+BX], AL
            MOV    [A+BX+1], AL
            JMP    CONT
    
      LAST: 
            MOV    CL, 05H
            MOV    BX, 00H
            MOV    DX, OFFSET MSG2
            MOV    AH, 09H
            INT    21H
            MOV    DX, 00H
          
      LOOP3:
            MOV    DL, [A+BX]
            MOV    AH, 02H
            INT    21H
            INC    BX
            DEC    CL
            JNZ    LOOP3
            MOV    AH, 4CH
            INT    21H
    
CODE ENDS
END START
