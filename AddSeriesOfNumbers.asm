DATA SEGMENT
    MSG1  DB 0DH, 0AH, "ENTER THE NUMBERS : $"
    MSG2  DB ": $"
    MSG3  DB 0DH, 0AH, 0DH, 0AH, "THE SUM OF THE NUMBERS IS : $"
    MSG4  DB 0DH, 0AH, " $"

    ARRN  DB 06 DUP(00H)                                            ; ARRAY OF NUMBERS
    LEN   DB 06                                                     ; LENGTH OF ARRAY
    TOTAL DW 0000H
DATA ENDS

CODE SEGMENT
           ASSUME CS:CODE, DS:DATA
    START: 
           MOV    AX, DATA
           MOV    DS, AX

           MOV    AH, 09H
           LEA    DX, MSG1
           INT    21H

           LEA    SI , ARRN           ; SI POINTS TO ARRN AND GET THE NUMBERS
           MOV    CL, LEN
           MOV    BL, 01H
    
    BK1:   MOV    AH, 09H
           LEA    DX, MSG4
           INT    21H
           MOV    AH, 02H
           MOV    DL, BL
           ADD    DL, 30H
           INT    21H
           INC    BL
           MOV    AH, 09H

           LEA    DX, MSG2
           INT    21H
           CALL   BAGET8
           MOV    [SI], AL
           INC    SI
           DEC    CL
           JNZ    BK1

    CALC:  LEA    SI, ARRN
           MOV    CL, LEN
           MOV    AX, TOTAL
        
    BK2:   ADD    AL, [SI]
           JNC    SKIP2
           INC    AH
    SKIP2: INC    SI
           DEC    CL
           JNZ    BK2
           MOV    TOTAL, AX

    SHOW:  MOV    AH, 09H
           LEA    DX, MSG3
           INT    21H
           LEA    SI, TOTAL
           INC    SI
           CALL   BAPUT8
           DEC    SI
           CALL   BAPUT8

    EXIT:  MOV    AH, 4CH
           INT    21H

BAGET8 PROC                           ; PROCEDURE TO GET 8 BIT NUMBER
           PUSH   CX                  ; SAVING CX
           MOV    AH, 01H             ; ACCEPTING A CHARACTER
           INT    21H
           SUB    AL, 30H             ; CONVERTING ASCII TO BINARY
           CMP    AL, 09H             ; CONVERTING ASCII TO BINARY
           JLE    G1                  ; IF AL IS LESS THAN OR EQUAL TO 9 THEN JUMP TO G1
           SUB    AL, 07H             ; CONVERTING ASCII TO BINARY

    G1:    MOV    CL, 04H
           ROL    AL, CL
           MOV    CH, AL

           MOV    AH, 01H             ; ACCEPTING A CHARACTER
           INT    21H
           SUB    AL, 30H             ; CONVERTING ASCII TO BINARY
           CMP    AL, 09H             ; CONVERTING ASCII TO BINARY
           JLE    G2                  ; IF AL IS LESS THAN OR EQUAL TO 9 THEN JUMP TO G1
           SUB    AL, 07H             ; CONVERTING ASCII TO BINARY

    G2:    ADD    AL, CH
           POP    CX                  ; RESTORING CX
           RET                        ; RETURNING TO MAIN PROGRAM
           ENDP

BAPUT8 PROC
           PUSH   CX
           MOV    AL, [SI]
           AND    AL, 0F0H
           MOV    CL , 04H
           ROL    AL, CL
           ADD    AL, 30H
           CMP    AL, 39H
           JLE    P1
           ADD    AL, 07H
    P1:    MOV    AH, 02H
           MOV    DL, AL
           INT    21H

           MOV    AL, [SI]
           AND    AL, 0FH
           ADD    AL, 30H
           CMP    AL, 39H
           JLE    P2
           ADD    AL, 07H
    P2:    MOV    AH, 02H
           MOV    DL, AL
           INT    21H
           POP    CX
           RET
           ENDP
CODE ENDS
END START