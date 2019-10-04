		.text
		.global _start
_start:
		LDR R4, =RESULT		// R4 points to the result location 
		LDR R2, [R4, #4]	// R2 holds the number of elements in the list
		ADD R3, R4, #8		// R3 points to the first number
		LDR R0, [R3]		// R0 holds the max number in the list
		LDR R5, [R3]		// R5 holds the min number in the list

LOOP:	SUBS R2, R2, #1 	// decrement the loop counter
		BEQ DONE			// end loop if counter has reached 0
		ADD R3, R3, #4		// R3 points to next number in the list
		LDR R1, [R3]		// R1 holds the next number in the list

		CMP R0, R1			// check if R0 is g/equal than R1( greater than the maximum)
//		BGE LOOP			// if yes, branch back to the loop, need to move to other place, not here
		BGE MIN 			// jump to find min
		MOV R0, R1			// update the current max

MIN:						// find min
		CMP R5, R1			// if (R5<R1)
		MOV R5, R1			// swap
	
		B LOOP				// branch back to the loop


DONE:	SUBS R0, R0, R5		// sub R5(min value) from R0 and strore the result in R0
		STR R0, [R4]		// store the result to the memory location

END:	B END				// infinite loop!

RESULT:	.word	0			// memory assigned for result location
N:		.word	7			// number of entries in the list
NUMBERS:.word	4,5,3,6		// the list data
		.word	1,8,2
