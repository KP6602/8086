DATA SEGMENT
    MSG  DB 0AH, 0DH, "ENTER STRING: $"
    MSG1 DB 0AH, 0DH, "STRING IS PALINDROME$"
    MSG2 DB 0AH, 0DH, "STRING IS NOT PALINDROME$"
DATA ENDS

CODE SEGMENT
           ASSUME CS:CODE, DS: DATA
    START: MOV    AX, DATA
           MOV    DS, AX
           MOV    DX, OFFSET MSG
           MOV    AH, 09H
           INT    21H
           MOV    SI, 1000H
           MOV    DI, 2000H
           MOV    CL, 00H
    UP:    MOV    AH, 01H
           INT    21H
           MOV    [SI], AL
           MOV    [DI], AL
           INC    SI
           INC    DI
           INC    CL
           CMP    AL, 0DH
           JNZ    UP
           MOV    SI, 1000H
           SUB    DI, 02H
           DEC    CL
    UP1:   MOV    BL, [SI]
           CMP    BL, [DI]
           JNZ    PALNOT
           INC    SI
           DEC    DI
           DEC    CL
           JZ     PAL
           JMP    UP1
    PALNOT:MOV    DX, OFFSET MSG2
           MOV    AH, 09H
           INT    21H
           JMP    EX
    PAL:   MOV    DX, OFFSET MSG1
           MOV    AH, 09H
           INT    21H
    EX:    MOV    AH, 4CH
           INT    21H
CODE ENDS
END START