;Write an ALP to add 2 Numbers 

DATA SEGMENT
    MSG1  DB 0DH, 0AH, "Enter the first number: $"
    MSG2  DB 0DH, 0AH, "Enter the second number: $"
    MSG3  DB 0DH, 0AH, 0DH, 0AH, "The Sum is: $"
    MSG4  DB 0DH, 0AH, "The Carry is: $"
    A     DW ?
    B     DW ?
    SUM   DW ?
    CARRY DB 00H
DATA ENDS

CODE SEGMENT
           ASSUME CS:CODE,DS:DATA
    START: 
           MOV    AX, DATA           ; INITIALIZING DATA SEGMENT
           MOV    DS, AX

           MOV    AH, 09H            ; PRINTING MSG1
           LEA    DX, MSG1
           INT    21H
           LEA    SI, A
           CALL   BAGET8             ; CALLING PROCEDURE TO GET 8 BIT NUMBER
           MOV    [SI+1], AL         ; MOVING AL TO A
           CALL   BAGET8             ; CALLING PROCEDURE TO GET 8 BIT NUMBER
           MOV    [SI], AL           ; MOVING AL TO A

           MOV    AH, 09H            ; PRINTING MSG2
           LEA    DX, MSG2
           INT    21H
           LEA    SI, B
           CALL   BAGET8             ; CALLING PROCEDURE TO GET 8 BIT NUMBER
           MOV    [SI+1], AL         ; MOVING AL TO A
           CALL   BAGET8             ; CALLING PROCEDURE TO GET 8 BIT NUMBER
           MOV    [SI], AL
             
           MOV    AX, A              ; MOVING A TO AL
           ADD    AX, B              ; ADDING B TO AL
           JNC    SKIP
           INC    CARRY
    SKIP:  MOV    SUM, AX            ; MOVING AX TO SUM

           MOV    AH, 09H            ; PRINTING MSG3
           LEA    DX, MSG3
           INT    21H
           LEA    SI, SUM
           INC    SI
           CALL   BAPUT8
           DEC    SI
           CALL   BAPUT8
             
           MOV    AH, 09H            ; PRINTING MSG4
           LEA    DX, MSG4
           INT    21H
           LEA    SI, CARRY
           CALL   BAPUT8
                  
           MOV    AH, 4CH            ; TERMINATE PROGRAM AND GO BACK TO DOS
           INT    21H

BAGET8 PROC                          ; PROCEDURE TO GET 8 BIT NUMBER
           PUSH   CX                 ; SAVING CX
           MOV    AH, 01H            ; ACCEPTING A CHARACTER
           INT    21H
           SUB    AL, 30H            ; CONVERTING ASCII TO BINARY
           CMP    AL, 09H            ; CONVERTING ASCII TO BINARY
           JLE    G1                 ; IF AL IS LESS THAN OR EQUAL TO 9 THEN JUMP TO G1
           SUB    AL, 07H            ; CONVERTING ASCII TO BINARY

    G1:    MOV    CL, 04H
           ROL    AL, CL
           MOV    CH, AL

           MOV    AH, 01H            ; ACCEPTING A CHARACTER
           INT    21H
           SUB    AL, 30H            ; CONVERTING ASCII TO BINARY
           CMP    AL, 09H            ; CONVERTING ASCII TO BINARY
           JLE    G2                 ; IF AL IS LESS THAN OR EQUAL TO 9 THEN JUMP TO G1
           SUB    AL, 07H            ; CONVERTING ASCII TO BINARY

    G2:    ADD    AL, CH
           POP    CX                 ; RESTORING CX
           RET                       ; RETURNING TO MAIN PROGRAM
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