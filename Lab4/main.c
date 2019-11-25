#include <stdio.h>

#include "./drivers/inc/VGA.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/ps2_keyboard.h"

void test_char() {
	int x,y;
	char c = 0;
	
	for (y=0; y <= 59; y++) {
		for (x=0; x<= 79; x++) {
			VGA_write_char_ASM(x, y, c++);
		}
	}
}

void test_byte() {
	int x,y;
	char c = 0;
	
	for (y=0; y< 59; y++) {
		for (x=0; x<= 79; x+=3) {
			VGA_write_byte_ASM(x, y, c++);
		}
	}
}

void test_pixel() {
	int x,y;
	unsigned short colour = 0;
	
	for (y=0; y<=239; y++) {
		for (x=0; x<=319; x++) {
			VGA_draw_point_ASM(x,y,colour++);
		}
	}
}


/*
int main() {
//	test_pixel(); 
//VGA_clear_pixelbuff_ASM();
//	test_byte();
//	test_char();
//VGA_clear_charbuff_ASM();
	return 0;
}
*/
 




 //--------------------------------------------PART 1 -  VGA-----------------------------------------------------------------
/*
int main() {
	
	while(1) { 										
		
		if(PB_data_is_pressed_ASM(PB0)){
			if (read_slider_switches_ASM() != 0) {
				test_byte();         //HEXADECIMAL VALUES
		}
		else {
			test_char();			// ASCII VALUES
			
		}}
		if(PB_data_is_pressed_ASM(PB1)){
			test_pixel();		 	//COLOURS
		}
	
		if(PB_data_is_pressed_ASM(PB2)){
		VGA_clear_charbuff_ASM();
		}
		if(PB_data_is_pressed_ASM(PB3)){
		VGA_clear_pixelbuff_ASM(); 
		}	
	
	}
	return 0;
}
*/


//--------------- PS/2 ------------------
// check RVALID in ps2 register, valid -> store data in char pointer and return 1, if invalid --> return 0

int main() {
	int x = 0;
	int y = 0;
	int ps2;
	char *c;
	
	VGA_clear_charbuff_ASM();						// Initially clear screen
	VGA_clear_pixelbuff_ASM();
    
	while(1) {
		ps2 = read_PS2_data_ASM(c);				// Get RVALID bit
		if (ps2) {                                  // if true, ps2 <-> c
			VGA_write_byte_ASM(x, y, *c);		    // Write to screen
			x = x + 3;								// increment by 3 -> each byte displays 2 characters
		}
        // test byte so x <-> 79, y <-> 59
		if (x > 79) {								// Check for x bounds
			x = 0;
			y++;
		}
		if (y > 59) {								// Check for y bounds
			VGA_clear_charbuff_ASM();				// Clear screen when it's filled out
			y = 0;									// reset y
		}
	}
	return 0;
}

