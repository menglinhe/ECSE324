			.text
			.global _start
_start:                      //Code to find the minimum from a list of numbers with length N
		
			LDR R4, =RESULT		//R4 points to the result location 
			LDR R2, [R4, #4]	//R2 holds the number of elements in the list
			ADD R3, R4, #8		//R3 points to the first number 
			LDR R0, [R3]		//R0 holds the first number in the list
			PUSH {R4-R12,R14}   // R4-12, R14 pushed onto the stack
			BL LOOP             // Branch to LOOP
			STR R0, [R4]		// Value in R0 (the min) stored into RESULT
			B END               // Branch to END
			
LOOP:		
		
			SUBS R2, R2, #1 	// decrement the loop counter
			BEQ DONE			// BEQ=branch if equal.....end loop if counter has reached 0
			ADD R3, R3, #4		// R3 points to next number in the list
			LDR R1, [R3]		// R1 holds the next number in the list
			CMP R0, R1			// check if R0 is lower/equal to R1
			BLE LOOP			// if yes, branch back to the loop
			MOV R0, R1			// if no, update the current min
			B LOOP				// branch back to the loop


DONE:		MOV R1, R14 		// LR
			POP {R4-R12,R14}	// R4-R12, R14 popped from the stack into the registers
			BX R1			   	// Branch to where LR pointed to before popping the stack
	
END:		B END				// infinite loop!

RESULT: 	.word	0			// memory assigned for result location
N:			.word	3			// number of entries in the list
NUMBERS:	.word 	11,9,17		// the list data
	
