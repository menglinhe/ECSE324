			.text
			.global _start

_start:
			
			LDR R4, =RESULT			// R4 points to the location of RESULT
			LDR R1, [R4, #4]		// R1 stores N
			
			MOV R0, #1              // Move value 1 into R0
			SUB R2, R2, R2          // R2 = 0
			CMP R1,R2               // Compare N and R0
			BEQ BASE                // If N = 0, then branch to BASE
			
			
			PUSH {R4,R14}           // Push R4 and R14 into Stack
			BL FACT					//Branch to FACT
			STR R0, [R4] 			// Store value in R0 (Factorial) into RESULT
			B END					//Branch to END

BASE:
			STR R0, [R4]			//Store value in R0 (Factorial) into RESULT
			B END					// Branch to END

FACT:								//Sub Routine CODE
	
			MUL R0, R0, R1       	// R0 = 1*(N)
			SUBS R1, R1, #1        // N = N - 1
			BEQ DONE			   // Branch to DONE if value in R1 becomes 0
			B FACT				   // Or branch back to FACT if value in R1 >0
			

DONE:	
			MOV R1, R14			  // R1 points to wherever LR points to
			POP {R4,R14}         // Pop values from stack into registers
			BX R1				// Branch back to where R1 points to
			 
END:		B END				// Branch to END

RESULT:		.word	0			
N: 			.word	5			
