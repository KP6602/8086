DATA SEGMENT
    MSG1 DB 0DH, 0AH, "ENTER 5 NUMBERS: $"
    MSG2 DB 0DH, 0AH, "LARGEST NUMBER IS: $"
DATA ENDS

CODE SEGMENT
          ASSUME CS: CODE, DS: DATA
    START:MOV    AX, DATA
          MOV    DS, AX
          MOV    SI, 6000H
          MOV    [SI], 1000H
          MOv    CL, 05H
    S:    MOV    DX, OFFSET MSG1
          MOV    AH, 09H
          INT    21H
    S1:   MOV    AH, 01H
          INT    21H
          CMP    AL, BYTE PTR[SI]
          JGE    S2
    S4:   DEC    CL
          CMP    CL, 00H
          JNZ    S
          JMP    S3
    S2:   MOV    [SI], AL
          JMP    S4
    S3:   MOV    DX, OFFSET MSG2
          MOV    AH, 09H
          INT    21H
          MOV    BX, [SI]
          MOV    DX, BX
          MOV    AH, 02H
          INT    21H
          MOV    AH, 4CH
          INT    21H
CODE ENDS
END START