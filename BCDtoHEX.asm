;Write ALP to convert BCD number to its Hexadecimal equivalent.

DATA SEGMENT
      MSG1 DB 0DH,0AH,"ENTER THE BCD NUMBER: $"
      MSG2 DB 0DH,0AH,"HEXADECIMAL: $"
      ABC  DW ?
DATA ENDS

CODE SEGMENT
            ASSUME CS:CODE,DS:DATA
      START:MOV    AX,DATA
            MOV    DS,AX
            MOV    DX,OFFSET MSG1
            MOV    AH,09H
            INT    21H
            MOV    SI,1000H
      L1:   MOV    AH,01H
            INT    21H
            SUB    AL,30H
            MOV    [SI],AL
            INC    SI
            ADD    AL,30H

            CMP    AL,0DH
            JNE    L1
            MOV    AL,[SI-3]
            MOV    BL,0AH
            MUL    BL
            MOV    DL,[SI-2]
            MOV    DH,00H
            ADD    AX,DX
            MOV    ABC,AX
            MOV    DX,OFFSET MSG2
            MOV    AH,09H
            INT    21H
            MOV    CL,04H
            MOV    AX,ABC
      L2:   MOV    DX,00H
            MOV    BX,0010H
            DIV    BX
            CMP    DX,000AH
            JNAE   HEXA
            ADD    DX,07H
      HEXA: ADD    DX,30H
            PUSH   DX
            DEC    CL
            JNZ    L2
            MOV    CL,04H
      DIS:  POP    DX

            MOV    AH,02H
            INT    21H
            DEC    CL
            JNZ    DIS
            MOV    AH,4CH
            INT    21H
CODE ENDS
END START