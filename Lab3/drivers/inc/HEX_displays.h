#ifndef _HEX_DISPLAYS
#define _HEX_DISPLAYS
	
	typedef enum {
		HEX0 = 0x00000001,
		HEX1 = 0x00000002,
		HEX2 = 0x00000004,
		HEX3 = 0x00000008,
		HEX4 = 0x00000010,
		HEX5 = 0x00000020
	}HEX_t;
	extern void HEX_clear_ASM(HEX_t hex); //turns off all the segements of all the HEX displays passed in the argument
	extern void HEX_flood_ASM(HEX_t hex); //turns on all the segments
	extern void HEX_write_ASM(HEX_t hex, char val); //takes a second argument val, which is a number between 0-15
													//based on this number, the subroutine will display the corresponding hexadecimal digit (0,1,2,...,A,..,F)
#endif												
