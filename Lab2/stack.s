			.text
			.global _start

_start:
			MOV R0,#2 		//value of 2 moved into R0
			PUSH {R0}		//Value stored in R0 pushed onto stack
			MOV R0,#3		//value of 3 moved into R0
			PUSH {R0}		//Value stored in R0 pushed onto stack
			MOV R0,#4		//value of 4 moved into R0
			PUSH {R0}		//Value stored in R0 pushed onto stack
			POP {R1-R3} 	//values popped from the stack and stored into R1-R3, 
END:
			B END
