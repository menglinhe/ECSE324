#ifndef __VGA
#define __VGA

	void VGA_clear_charbuff_ASM(); //clear (set to 0) all the valid memory locations in the character buffer
	void VGA_clear_pixelbuff_ASM(); //clear (set to 0) all the valid memory locations in the pixel buffer
	
	void VGA_write_char_ASM(int x, int y, char c);		// write ASCII code passed in third argument to the screen at (x,y) coordinates
	void VGA_write_byte_ASM(int x, int y,	char byte); //write the hexademical representation of the value passed in the third argument to the screen 
	
	void VGA_draw_point_ASM(int x, int y, short colour); //draw a point on the screen with the colour as indicated in the third argument, by accessing only the pixel buffer memory

#endif
