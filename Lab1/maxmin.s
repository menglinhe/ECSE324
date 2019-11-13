		.text
		.global _start

_start:		LDR R0, =MAX		// AR0 points to address of MAX
			LDR R1, =MIN		// R1 points to address of MIN
			LDR R2, [R0, #8]	// Value of n
			LDR R3, [R0, #12]	// Value of m
			ADD R4, R0, #16		// R4 points to address of first num 
			ADD R5, R0, #20 	// R5 points to address of second num

			ADD R6, R2, R3		// R6 = n + m , R6 will act as a counter.
			SUB R7, R7, R7		// R7 = sum = 0

SUM:			 
			LDR R8, [R4]		// R8 stores value of first num
			ADD R7, R7, R8		// First num added to R7 = R7 + first num = 0 + first num
			ADD R4, R4, #4		// R4 points to address of second num
			SUBS R6, R6, #1		// Counter decrement
			BEQ RESET			// Branch to RESET if R6-R6=0 or counter = 0
			B SUM           	// Branch to SUM 

RESET:
			ADD R4, R0, #16		// R4 points to address of first num
			SUB R6, R6, R6		// Reset Counter
			ADD R6, R2, R3		// Reset Counter
			LDR R8, [R4]		// R8 stores value of first num 

			LDR R9, [R0]		// R9 stores MAX value
			LDR R10, [R1]		// R10 stores MIN Value

LOOP:
			SUBS R6, R6, #1		// counter decrement
			BEQ DONE			// Exit if counter = 0
			LDR R11, [R5]		// Second number loaded into R11 as R5 points to second num
			ADD R5, R5, #4		// R5 points to next number (initially from 2nd num to 3rd num)			
			ADD R12, R8, R11 	// First num + next num loaded into R12 (X = sum of numbers on LHS)
			SUB R2, R7, R12 	// S - X 
			MUL R3, R12, R2		// X*(S-X)
			CMP R9, R3			// Compare R9(current MAX value) and R3[X*(S-X)]
			BLE CHANGEMAX		// If current MAX lower or equal to R3[X*(S-X)], then change MAX
			B MINCHECK			// Or else, check for MIN

CHANGEMAX:	MOV R9, R3      	// As R3[X*(S-X)] was greater than current MAX , move [X*(S-X)] into R9

MINCHECK: 	CMP R10, R3			// Compare R10(current MIN value) and R3[X*(S-X)]
			BGE CHANGEMIN		// if current MIN greater or equal to R3[X*(S-X)], then change MIN
			B LOOP				// OR else Branch to LOOP

CHANGEMIN:	MOV R10, R3         // As R3[X*(S-X)] was lower than current MIN, move R3[X*(S-X)] into R10 
			B LOOP			
			
DONE:		STR R9, [R0]		// Store R9 = MAX into R0
			STR R10, [R1]		// Store R10 = MIN into R1
		 
END:		B END				// infinite loop

MAX:		.word	0			//	Minimum 32 bit number
MIN:		.word	2147483647	//	Maximum 32 bit number
N: 			.word	2			
M:			.word	2			
NUMBERS:	.word	-1, 0, 2, 3	// the list data
