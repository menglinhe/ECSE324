.text
		.equ PB_DATA, 0xFF200050
		.equ PB_MASK, 0xFF200058
		.equ PB_EDGE, 0xFF20005C
		
		.global read_PB_data_ASM
		.global PB_data_is_pressed_ASM
		
		.global read_PB_edgecap_ASM
		.global PB_edgecap_is_pressed_ASM
		.global PB_clear_edgecap_ASM
		
		.global enable_PB_INT_ASM
		.global disable_PB_INT_ASM

read_PB_data_ASM:             //no input
		LDR R1, =PB_DATA	
		LDR R0, [R1]			
		BX LR

PB_data_is_pressed_ASM:
		LDR R1, =PB_DATA	
		LDR R2, [R1]				
		AND R3, R2, R0
		CMP R3, R0
		MOVEQ R0, #1				
		MOVNE R0, #0				
		BX LR

read_PB_edgecap_ASM:           //no input
		LDR R1, =PB_EDGE 
		LDR R0, [R1]
		BX LR

PB_edgecap_is_pressed_ASM:		
		LDR R1, =PB_EDGE
		LDR R2, [R1]	
		AND R3, R2, R0
		CMP R3, R0
		MOVEQ R0, #1
		MOVNE R0, #0
		BX LR

PB_clear_edgecap_ASM:     				
		LDR R1, =PB_EDGE
		STR R0, [R1]             //Performing a write operation to theEdgecaptureregister sets all bits in the register to 0, and clears any associated interrupts
		BX LR

enable_PB_INT_ASM:			
		LDR R1, =PB_MASK
		STR R0, [R1]				
		BX LR

disable_PB_INT_ASM:					
		LDR R1, =PB_MASK			
		LDR R2, [R1]				
		BIC R2, R2, R0										
		STR R2, [R1]				
		BX LR
		
		.end




