;Write ALP to perform multiplication of two single digit numbers using Macro.

DATA SEGMENT
    MSG1   DB  0DH, 0AH, "Enter the first number: $"
    MSG2   DB  0DH, 0AH, "Enter the second number: $"
    MSG3   DB  0DH, 0AH, "The product is: $"
    NUM1   DB  ?
    NUM2   DB  ?
    RESULT DW  ?

PRINT MACRO MSG
                 MOV AH, 09H
                 MOV DX, OFFSET MSG
                 INT 21H
ENDM

DATA ENDS

CODE SEGMENT
          ASSUME CS:CODE, DS:DATA
    START:
          MOV    AX, DATA
          MOV    DS, AX
          PRINT  MSG1
          MOV    AH, 01H
          INT    21H
          SUB    AL, 30H
          MOV    NUM1, AL
          PRINT  MSG2
          MOV    AH, 01H
          INT    21H
          SUB    AL, 30H
          MOV    NUM2, AL
          MUL    NUM1
          MOV    RESULT, AX
          AAM
          ADD    AL, 30H
          ADD    AH, 30H
          MOV    BX, AX
          PRINT  MSG3
          MOV    AH, 02H
          MOV    DL, BH
          INT    21H
          MOV    AH, 02H
          MOV    DL, BL
          INT    21H
          MOV    AH, 4CH
          INT    21H
CODE ENDS
    END START