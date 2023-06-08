DATA SEGMENT
    MSG  DB 0AH, 0DH, "Hello$"
DATA ENDS

CODE SEGMENT
          ASSUME CS: CODE, DS: DATA
    START:
          MOV    AX, DATA
          MOV    DS, AX
          MOV    AH, 09H
          MOV    DX, OFFSET MSG
          INT    21H
          MOV    AH, 4CH
          INT    21H
CODE ENDS
END START