	.text
	.equ PS2_data, 0xFF200100
	.global read_PS2_data_ASM

read_PS2_data_ASM:
	PUSH {R1-R2, LR}		// store used registers for subroutine
	LDR R1, =PS2_data
	LDR R1, [R1]			// reading from the memory location updates the data, so we can only read once!
	AND R2, R1, #0x8000		// AND R2, R1 to clear all bits except the RVALID

	CMP R2, #1			    // compare R2 with 1, assign 0 if R0<0
	MOVLT R0, #0		    // if RVALID = 0, leave and return 0
	BLT END
	
	AND R1, #0xFF 		    // AND R1 with mask -> clear all bits except data bits
	STR R1, [R0]
	MOV R0, #1			    // 1 -> valid data

END:
	POP {R1-R2, LR}		    // pop used registers
	BX LR
