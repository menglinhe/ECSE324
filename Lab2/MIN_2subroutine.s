	.text
	.global MIN_2
MIN_2:
	CMP R0, R1    //compare 'a'(min) and 'b'
	BXLE LR       // if 'a' is still the min then branch back to where LR points to
	MOV R0, R1    // else , move 'b' into where 'a' was
	BX LR         // Branch back to where LR points to
	.end
