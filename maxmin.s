			.text
			.global _start

_start:     LDR R0, =MAX        // ADDRESS OF MAX
            LDR R1, =MIN        // ADDRESS OF MIN
            LDR R2, [R1, #4]    // VALUE OF N
            LDR R3, [R1, #8]    // VALUE OF M
            ADD R4, R1, #12     // ADDRESS OF FIRST NUMBER IN THE LIST
            ADD R5, R1, #16     // ADDRESS OF SECOND NUMBER IN THE LIST
            ADD R6, R2, R3      // COUNTER POSITION N+M
            SUB R7, R7, R7      // STORE SUM = 0 TO R7

EXPSUM:     LDR R8, [R4]        // LOAD VALUE OF R4 TO R8, R4: 1ST NUMBER IN THE LIST
            ADD R7, R7, R8      // ADD FIRST NUMBER AND SUM TOGETHER AND STORE IN SUM(R7)
            ADD R4, R4, #4      // UPDATE R4 TO NEXT ELEMENT
            SUB R6, R6, #1      // COUNTER DECREMENTAL
            BEQ RESET           // EXIT LOOP
            B EXPSUM            // BRANCH END FOR EXPSUM

RESET:      ADD R4, R1, #12     // MIN NOW POINTS TO THE FIRST NUMBER IN THE LIST AND STORE IN R4
            SUB R6, R6, R6      // SET COUNTER POSITION R6 = 0
            ADD R6, R2, R3      // COUNTER POSITION TO N+M
            LDR R9, [R4]        // LOAD R9 WITH VALUE OF R4 ->FIRST NUMBER IN THE ELEMENT
            LDR R3, [R0]        // LOAD R3 (VALUE OF M) WITH MAX VALUE
            LDR R4, [R1]        // LOAD R4 WITH MIN VALUE
            

LOOP:       SUB R6, R6, #1      // DECREMENTAL COUNTER
            BEQ DONE            // END LOOP IF COUNTER IS 0
            LDR R10, [R5]       // LOAD R10 WITH SECOND NUMBER IN THE LIST
            ADD R5, R5, #4      // UPDATE R5 TO NEXT ELEMENT

            ADD R11, R9, R10    // INITIALIZE XSUM TO R9 + R10 AND STORE IN R11
            SUB R12, R7, R11    // INITIALIZE YSUM TO SUM - XSUM
            MUL R2, R11, R12    // GENERATE EXPRESSION RESULT AND STORE IN R2

            CMP R3 R2           // COMPARE RESULT WITH MAX
            BLE SWAPMAX         // BRANCH IF MAX IS SMALL
            B MIN

SWAPMAX:    MOV R3 R2           // SWAP THE RESULT AND CURRENT MAX
    
MIN:        CMP R4 R2           // COMPARE RESULT WITH MIN
            BGE SWAPMIN         // BRANCH IF RESULT IS SAMLL
            B LOOP              // BRANCH BACK TO LOOP

SWAPMIN:    MOV R4 R2           // SWAP THE RESULT AND CURRENT MIN
            B LOOP              // BRANCH BACK TO LOOP

DONE:       STR R3 [R0]         // STORE EXPRESSION MAX VALUE TO R3
            STR R4 [R1]         // STORE EXPRESSION MIN VALUE TO R4

END:        B END

MAX:        .word   0           // MAX VALUE MEMORY LOCATION
MIN:        .word   2147483647  // MIN VALUE MEMORY LOCATION
N:          .word   2           // N VALUE FOR THE EXPRESSION
M:          .word   2           // M VALUE FOR THE EXPRESSION
NUMBERS:    .word   1,2,3,4     // INPUT NUMBERS
