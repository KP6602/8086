DATA SEGMENT
    MSG  DB 0AH, 0DH, "Enter a Number : $"
    MSG1 DB 0AH, 0DH, "The Number is Even $"
    MSG2 DB 0AH, 0DH, "The Number is Odd $"
DATA ENDS

CODE SEGMENT
          ASSUME CS:CODE, DS:DATA
    START:
          MOV    AX, DATA
          MOV    DS, AX
          MOV    AH, 09H
          MOV    DX, OFFSET MSG
          INT    21H
    S1:   MOV    AH, 01H
          INT    21H
          ROR    AL, 01H
          JNC    EVEN1
          MOV    AH, 09H
          MOV    DX, OFFSET MSG2
          INT    21H
          JMP    END
    EVEN1:MOV    AH, 09H
          MOV    DX, OFFSET MSG1
          INT    21H
    END:  MOV    AH, 4CH
          INT    21H
CODE ENDS
END START
