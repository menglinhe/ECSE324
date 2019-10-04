			.text
			.global _start
_start:
			LDR R4, =RESULT		//R4 points to the result location R4=0x38
			LDR R2, [R4, #4]	//R2 holds the number of elements in the list R4+4 = 0x3c; R2=7
			ADD R3, R4, #8		//R3 points to the first number; R3= R4+8=0x38 + 8 = 0x40
			LDR R0, [R3]		//R0 holds the first number in the list; R0 = 4

LOOP:		SUBS R2, R2, #1 	// decrement the loop counter // flag, for comparaion
			BEQ DONE			// end loop if counter has reached 0
			ADD R3, R3, #4		// R3 points to next number in the list
			LDR R1, [R3]		// R1 holds the next number in the list
			CMP R0, R1			// check if R0 is g/equal than R1( greater than the maximum)
			BGE LOOP			// if yes, branch back to the loop
			MOV R0, R1			// if no, update the current max
			B LOOP				// branch back to the loop


DONE:		STR R0, [R4]		// store the result to the memory location

END:		B END				// infinite loop!

RESULT: 	.word	0			// memory assigned for result location
N:			.word	7			// number of entries in the list
NUMBERS:	.word	4,5,3,6		// the list data
			.word	1,8,2
