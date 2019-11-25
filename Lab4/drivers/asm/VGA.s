.text
	
	.equ VGA_pixelbuff, 0xC8000000      // Pixel Buffer
	.equ VGA_charbuff, 0xC9000000		// Character Buffer

	.global VGA_clear_charbuff_ASM
	.global VGA_clear_pixelbuff_ASM
	
	.global VGA_write_char_ASM
	.global VGA_write_byte_ASM
	
	.global VGA_draw_point_ASM

VGA_clear_charbuff_ASM:
	PUSH {R4-R12} 
	SUB R0,R0,R0				// x counter				
	SUB R2,R2,R2
	LDR R3, =VGA_charbuff

X_CHAR: 
	SUB R1,R1,R1				// y counter
	ADD R4, R3, R0			

Y_CHAR: 
	ADD R5, R4, R1, LSL #7	
	
	STRB R2, [R5]			
	ADD R0, R0, #1			// x counter increment	
	CMP R0, #80			
	BLT X_CHAR
	ADD R1, R1, #1			// y counter increment
	CMP R1, #60				
	BLT Y_CHAR
	POP {R4-R12}
	BX LR


VGA_clear_pixelbuff_ASM:
	PUSH {R4-R12}	
	SUB R0,R0,R0						// X counter
	SUB R2,R2,R2
	LDR R3, =VGA_pixelbuff

X_PIXEL:
	SUB R1,R1,R1						// Y counter
	ADD R4, R3, R0, LSL #1		
Y_PIXEL:
	ADD R5, R4, R1, LSL #10			
	
	STRH R2, [R5]					
	ADD R0, R0, #1					// x counter increment	
	CMP R0, #320					
	BLT X_PIXEL
	ADD R1, R1, #1					// y counter increment
	CMP R1, #240					
	BLT Y_PIXEL				
	POP {R4-R12}
	BX LR

VGA_write_char_ASM:	
	PUSH {R3-R12}
	CMP R1, #59
	BXGT LR
	CMP R0, #79			
	BXGT LR

	LDR R3, =VGA_charbuff		// R3 holds the base address of character buffer
	ADD R3, R3, R0				// x coordinate determined
	ADD R3, R3, R1, LSL #7		// y coordinate determined
	STRB R2, [R3]				
	POP {R3-R12}
	BX LR

VGA_write_byte_ASM:
	PUSH {R3-R12}
	CMP R1, #59
	BXGT LR
	CMP R0, #78					
	BXGT LR						
	
	LDR R3, =VGA_charbuff			// R3 holds the base address of character buffer
	ADD R3, R3, R0					// x coordinate determined					
	ADD R3, R3, R1, LSL #7			// y coordinate determined
								
	LSR R4, R2, #4					// left hex					
	AND R5, R2, #0x0F				// right hex
	
	CMP R4, #9						// check if R4 has a num greater than 9
	ADDGT R4, R4, #7			    // if yes, add 7 (check ASCII table)
	CMP R5, #9						
	ADDGT R5, R5, #7
	ADD R4, R4, #48					// Add ASCII code of number 0
	ADD R5, R5, #48					// Add ASCII code of number 0
	
	STRB R4, [R3]					// Store left hex at the address that R3 points to
	STRB R5, [R3, #1]				// Store right hex at the next address that R3 points to
	POP {R3-R12}
	BX LR

VGA_draw_point_ASM:
	PUSH {R3-R12}
	CMP R1, #239
	BXGT LR
	LDR R3, =319				
	CMP R0, R3					
	BXGT LR
	LDR R3, =VGA_pixelbuff		// R3 holds the base address of pixel buffer
	ADD R3, R3, R0, LSL #1		// x coordinate determined
	ADD R3, R3, R1, LSL #10		// y coordinate determined
	STRH R2, [R3]				
	POP {R3-R12}
	BX LR

.end
