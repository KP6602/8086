;Write ALP to display message on the monitor using BIOS interrupt.

DATA SEGMENT
      MSG  DB "HIIIII KUNAL...Have a nice day...$"
DATA ENDS

CODE SEGMENT
            ASSUME CS:CODE , DS:DATA
      START:
            MOV    AX,DATA
            MOV    DS,AX
            MOV    AX,0501H
            INT    10H
            MOV    AH,02H
            MOV    BH,01H
            MOV    DX,0C20H
            INT    10H
            MOV    BX,OFFSET MSG
            MOV    CX , 000DH
      MORE: 
            MOV    AH,02H
            MOV    DL,[BX]
            INT    21H
            INC    BX
            DEC    CX
            JNZ    MORE
      DUN:  
            MOV    AH,07H
            INT    21H
            CMP    AL,"Q"
            JNE    DUN

            MOV    AX,0500H
            INT    10H
            MOV    AX,4C00H
            INT    21H
            MOV    AH,02H
            MOV    BH,01H
            MOV    DX,0C30H
            INT    10H
            MOV    BX,OFFSET MSG
            MOV    CX,0005H
            MOV    BH,4CH
            INT    21H
CODE ENDS
END START
