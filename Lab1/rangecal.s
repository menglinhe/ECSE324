			.text
			.global _start
_start:
			LDR R4, =RESULT		//R4 points to the result location                        ; R4=0x38
			LDR R2, [R4, #4]	//R2 holds the number of elements in the list             ; R4+4 = 0x3c; R2=7
			ADD R3, R4, #8		//R3 points to the first number                           ; R3= R4+8=0x38 + 8 = 0x40
			LDR R0, [R3]		//R0 holds the first number in the list (Max)             ; R0 = 4
			LDR R5, [R3]		// R5 holds the first number in the list (Min)

LOOP:		SUBS R2, R2, #1 	// decrement the loop counter
			BEQ DONE			// end loop if counter has reached 0
			ADD R3, R3, #4		// R3 points to next number in the list
			LDR R1, [R3]		// R1 holds the next number in the list
			CMP R0, R1			// check if R1 greater than current Max
			BGE MIN				// if no, branch to MINIMUM
			MOV R0, R1			// if yes, update the current max (content of R1 moved into R0)

MIN: 		CMP R5, R1          //check if R1 less than current Min
			BLE LOOP            //if NO, branch back to LOOP
			MOV R5, R1          // if YES, update the current Min (content of R1 moved into R5)
			B LOOP 			    // Branch back to LOOP

            
DONE:		SUB R6, R0, R5     // Calculate Max-Min = Range, put Range into R6
			STR R6, [R4]		// store the Range to the memory location (content of R6 stored into RESULT)

END:		B END				// infinite loop!

RESULT: 	.word	0			// memory assigned for result location
N:			.word	7			// number of entries in the list
NUMBERS:	.word	4,5,3,6		// the list data
			.word	1,8,2
