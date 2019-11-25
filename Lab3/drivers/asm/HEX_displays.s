.text
	.equ HEX0_BASE, 0xFF200020
	.equ HEX4_BASE, 0xFF200030
	.global HEX_clear_ASM //turns off all the segements of all the HEX displays passed in the argument
	.global HEX_flood_ASM //turns on all the segments of all the HEX displays passed in the argument
	.global HEX_write_ASM//takes a second argument val, which is a number between 0-15
													//based on this number, the subroutine will display the corresponding hexadecimal digit (0,1,2,...,A,..,F)
	
//HEX0= 0000 0000 0000 0000 0000 0000 0000 0001 , DATA REGISER1:  BITS 0-6 , 0000 0000 0000 0000 0000 0000 0111 1111
//HEX1= 0000 0000 0000 0000 0000 0000 0000 0010 , DATA REGISER1:  BITS 8-14 , 0000 0000 0000 0000 0111 1111 0000 0000
//HEX2= 0000 0000 0000 0000 0000 0000 0000 0100 , DATA REGISER1:  BITS 16-22 , 0000 0000 0111 1111 0000 0000 0000 0000
//HEX3= 0000 0000 0000 0000 0000 0000 0000 1000 , DATA REGISER1:  BITS 24-30 , 0111 1111 0000 0000 0000 0000 0000 0000

//HEX4= 0000 0000 0000 0000 0000 0000 0001 0000 , DATA REGISER2:  BITS 0-6 , 0000 0000 0000 0000 0000 0000 0111 1111
//HEX5= 0000 0000 0000 0000 0000 0000 0010 0000 , DATA REGISER2:  BITS 8-14 , 0000 0000 0000 0000 0111 1111 0000 0000
//HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5 = 0000 0000 0000 0000 0000 0000 0011 1111 , DATA REGISTER:  0111 1111 0111 1111 0111 1111 0111 1111

 
HEX_flood_ASM:
//R0 HAS THE HEX INPUT E.G. HEX0 
MOV R6, #4 			    //counter
SUB R7, R7, R7         // SET R7 = 0000 0000 0000 0000 0000 0000 0000 0000 

LDR R1, =HEX0_BASE      // R1 points to data register 1
LDR R2, [R1]           // R2 stores the content of data register 1
MOV R3, #0x00000001    //R3 stores binary value 0000 0000 0000 0000 0000 0000 0000 0001
MOV R4, #0x0000007F    // R4 stores binary value 0000 0000 0000 0000 0000 0000 0111 1111
B B1 

B1:
ANDS R5,R0,R3
BEQ B2
ORR R7,R7,R4
SUBS R6, R6, #1
BEQ DONE1
LSL R3, R3, #1
LSL R4, R4, #8
B B1

B2: 
SUBS R6, R6, #1
BEQ DONE1
LSL R3, R3, #1
LSL R4, R4, #8
B B1

DONE1:
ORR R2, R2, R7
STR R2, [R1] 
B HEX_flood_ASM2
//---------------------------------------------------------------------------------------------------------------------------------
HEX_flood_ASM2:
//R0 HAS THE HEX INPUT E.G. HEX0 
MOV R6, #2 			    //counter
SUB R7, R7, R7         // SET R7 = 0000 0000 0000 0000 0000 0000 0000 0000 

LDR R1, =HEX4_BASE      // R1 points to data register 1
LDR R2, [R1]           // R2 stores the content of data register 1
MOV R3, #0x00000010    //R3 stores binary value 0000 0000 0000 0000 0000 0000 0001 0000
MOV R4, #0x0000007F    // R4 stores binary value 0000 0000 0000 0000 0000 0000 0111 1111
B B3 

B3:
ANDS R5,R0,R3
BEQ B4
ORR R7,R7,R4
SUBS R6, R6, #1
BEQ DONE2
LSL R3, R3, #1
LSL R4, R4, #8
B B3

B4: 
SUBS R6, R6, #1
BEQ DONE2
LSL R3, R3, #1
LSL R4, R4, #8
B B3

DONE2:
ORR R2, R2, R7
STR R2, [R1] 
BX LR

//.....................................................................................................................................
//.....................................................................................................................................
//.....................................................................................................................................
//.....................................................................................................................................
/*
HEX_clear_ASM:
//R0 HAS THE HEX INPUT E.G. HEX0 
MOV R6, #4 			    //counter
LDR R8, =NUM 			    		
LDR R7, [R8]    		// SET R7 :	0111 1111 0111 1111 0111 1111 0111 1111

LDR R1, =HEX0_BASE      // R1 points to data register 1
LDR R2, [R1]           // R2 stores the content of data register 1
MOV R3, #0x00000008    //R3 stores binary value : 0000 0000 0000 0000 0000 0000 0000 1000
ORR R2, R2, R7
STR R2, [R1]            
MOV R4, #0X80FFFFFF 	// R4 stores binary value : 1000 0000 1111 1111 1111 1111 1111 1111
						
B B5 

B5:
ANDS R5,R0,R3
BEQ B6
AND R7,R7,R4
SUBS R6, R6, #1
BEQ DONE3
LSR R3, R3, #1
ROR R4, R4, #8
B B5

B6: 
SUBS R6, R6, #1
BEQ DONE3
LSR R3, R3, #1
ROR R4, R4, #8
B B5

DONE3:
STR R7, [R1] 
B HEX_clear_ASM2
//---------------------------------------------------------------------------------------------------------------------------------
HEX_clear_ASM2:
//R0 HAS THE HEX INPUT E.G. HEX0 
MOV R6, #2				//counter
LDR R8, =NUM 			    		
LDR R7, [R8]    		// SET R7 :	0111 1111 0111 1111 0111 1111 0111 1111

LDR R1, =HEX4_BASE      // R1 points to data register 1
LDR R2, [R1]           // R2 stores the content of data register 1
MOV R3, #0x00000020    //R3 stores binary value : 0000 0000 0000 0000 0000 0000 0010 0000
ORR R2, R2, R7
STR R2, [R1]            
MOV R4, #0XFFFF80FF 	// R4 stores binary value : 1111 1111 1111 1111 1000 0000 1111 1111
						
B B7 

B7:
ANDS R5,R0,R3
BEQ B8
AND R7,R7,R4
SUBS R6, R6, #1
BEQ DONE4
LSR R3, R3, #1
ROR R4, R4, #8
B B7

B8: 
SUBS R6, R6, #1
BEQ DONE4
LSR R3, R3, #1
ROR R4, R4, #8
B B7

DONE4:
STR R7, [R1]
BX LR
*/
//.....................................................................................................................................
//.....................................................................................................................................
//.....................................................................................................................................
//.....................................................................................................................................
HEX_clear_ASM:
			PUSH {R1-R8,R14}
			SUB R3,R3,R3
			LDR R1, =HEX0_BASE				
			
C1:			CMP R3, #6				
			BEQ C3	
			AND R4, R0, #1			
			CMP R4, #1					
			BLEQ C2

			ADD R3, R3, #1
			LSR R0, R0, #1 									
			B C1

C3:			POP {R1-R8, R14}
			BX LR

C2:			CMP R3, #3	
			LDRGT R1, =HEX4_BASE	
			SUBGT R3, R3, #4	
			LDR R5, =C4		
			LDR R2, [R1]					
			LSL R6, R3, #2		
			LDR R5, [R5, R6]					
			AND R2, R2, R5		
			STR R2, [R1]		
			BX LR


C4:			.word 0xFFFFFF00
			.word 0xFFFF00FF
			.word 0xFF00FFFF
			.word 0x00FFFFFF

//-/-/-/--/-/-/-/-/--/-/-/-/--/-/-/-/-/--/-/-/-/-/--/-/-/-/--//-/-/--/-/-/-/--/-/-/-/-/--/-/-/-/--/-/-/-/--/-/-/-/-/-/--/-/-/-/-/-/--/-/-/-/-/-/-
//-/-/-/--/-/-/-/-/--/-/-/-/--/-/-/-/-/--/-/-/-/-/--/-/-/-/--//-/-/--/-/-/-/--/-/-/-/-/--/-/-/-/--/-/-/-/--/-/-/-/-/-/--/-/-/-/-/-/--/-/-/-/-/-/-
//-/-/-/--/-/-/-/-/--/-/-/-/--/-/-/-/-/--/-/-/-/-/--/-/-/-/--//-/-/--/-/-/-/--/-/-/-/-/--/-/-/-/--/-/-/-/--/-/-/-/-/-/--/-/-/-/-/-/--/-/-/-/-/-/-



HEX_write_ASM:	MOV R9, R1
				MOV R10, R0							
				PUSH {R1-R8,R14}
				BL HEX_clear_ASM		
				POP {R1-R8,LR}			
				MOV R0, R10				
	
				PUSH {R1-R8,LR}
				SUB R3,R3,R3
				LDR R1, =HEX0_BASE						
				LDR R5, =HEXLIGHT			
				ADD R5, R5, R9, LSL #2	
								
				B W1

W1:			CMP R3, #6		
			BEQ W3
			AND R4, R0, #1		
			CMP R4, #1
			BLEQ W2

			LSR R0, R0, #1 		
								
			ADD R3, R3, #1		
			B W1

W3:			 POP {R1-R8, R14}
			BX LR

W2:			CMP R3, #3		
			SUBGT R3, R3, #4	
			LDRGT R1, =HEX4_BASE	
			LDR R7, [R5]
			LDR R2, [R1]				
			LSL R6, R3, #3		
			LSL R7, R7, R6		
			ORR R2, R2, R7		
			STR R2, [R1]		
			BX LR


HEXLIGHT:		.word 0x0000003F 
				.word 0x00000006 
				.word 0x0000005B 
				.word 0x0000004F 
				.word 0x00000066 
				.word 0x0000006D 
				.word 0x0000007D 
				.word 0x00000007 	
				.word 0x0000007F	
				.word 0x00000067 	
				.word 0x00000077 
				.word 0x0000007C 
				.word 0x00000039 
				.word 0x0000005E 
				.word 0x00000079 
				.word 0x00000071 
/*
HEX_write_ASM:
//R0 HAS THE HEX INPUT E.G. HEX0 
MOV R6, #4 			    //counter
SUB R7, R7, R7         // SET R7 = 0000 0000 0000 0000 0000 0000 0000 0000 
LDR R8, =HEX0_BASE      // R1 points to data register 1

PUSH {R6,R14}
BL C1

LDR R2, [R8]           // R2 stores the content of data register 1
MOV R3, #0x00000001    //R3 stores binary value 0000 0000 0000 0000 0000 0000 0000 0001
MOV R4, #0x0000007F    // R4 stores binary value 0000 0000 0000 0000 0000 0000 0111 1111
B B9 

B9:
ANDS R5,R0,R3
BEQ B10
//ORR R7,R7,R4
ORR R7, R7, R10
SUBS R6, R6, #1
BEQ DONE5
LSL R3, R3, #1
LSL R4, R4, #8
LSL R10, R10, #8
B B9

C1:
MOV R6, #15
CMP R1,R6
MOVEQ R10, #0X00000071
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000079
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000003F
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000039
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000007F
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000077
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000067
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000007F
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000007
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000007D
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000006D
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000066
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000004F
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000005B
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000006
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000003F
MOV R11,R14
POP {R6,R14}
BX R11

B10: 
SUBS R6, R6, #1
BEQ DONE5
LSL R3, R3, #1
LSL R4, R4, #8
LSL R10, R10, #8
B B9

DONE5:
ORR R2, R2, R7
STR R7, [R8] 
B HEX_write_ASM2
//---------------------------------------------------------------------------------------------------------------------------------
HEX_write_ASM2:
//R0 HAS THE HEX INPUT E.G. HEX0 
MOV R6, #2 			    //counter
SUB R7, R7, R7         // SET R7 = 0000 0000 0000 0000 0000 0000 0000 0000 
LDR R8, =HEX4_BASE      // R1 points to data register 1

PUSH {R6,R14}
BL C1

LDR R2, [R8]           // R2 stores the content of data register 1
MOV R3, #0x00000010    //R3 stores binary value 0000 0000 0000 0000 0000 0000 0001 0000
MOV R4, #0x0000007F    // R4 stores binary value 0000 0000 0000 0000 0000 0000 0111 1111
B B11 

B11:
ANDS R5,R0,R3
BEQ B12
//ORR R7,R7,R4
ORR R7,R7,R10
SUBS R6, R6, #1
BEQ DONE6
LSL R3, R3, #1
LSL R4, R4, #8
LSL R10, R10, #8
B B11

C2:
MOV R6, #15
CMP R1,R6
MOVEQ R10, #0X00000071
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000079
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000003F
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000039
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000007F
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000077
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000067
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000007F
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000007
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000007D
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000006D
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000066
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000004F
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000005B
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X00000006
SUB R6,R6,#1
CMP R1,R6
MOVEQ R10, #0X0000003F
MOV R11,R14
POP {R6,R14}
BX R11

B12: 
SUBS R6, R6, #1
BEQ DONE6
LSL R3, R3, #1
LSL R4, R4, #8
LSL R10, R10, #8
B B11

DONE6:
ORR R2, R2, R7
STR R7, [R8] 
BX LR
*/


NUM:		.word	2139062143	
.end

