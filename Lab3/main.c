#include <stdio.h>

#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/address_map_arm.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/HPS_TIM.h"

/*           
int main() {


	while(1) {
	write_LEDs_ASM(read_slider_switches_ASM());
	}

	return 0;
}


*/


/*			//PART1
int main() {
//HEX_flood_ASM(HEX0 | HEX1);
//HEX_clear_ASM(HEX2 | HEX4 |HEX5);
HEX_write_ASM(HEX0 | HEX2 |  HEX3 | HEX5, 15);
HEX_write_ASM(HEX0, 14);
HEX_write_ASM(HEX3, 2);





return 0;

}
*/


     			 //PART2
int main() {
	while(1){
		write_LEDs_ASM(read_slider_switches_ASM());
		if (read_slider_switches_ASM() & 0x200) {
			HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5); 
		} else {
			HEX_flood_ASM(HEX4 | HEX5);
			
			if(read_PB_data_ASM() == 1){
				HEX_write_ASM(HEX0, read_slider_switches_ASM());
			}

			if(read_PB_data_ASM() == 2){
				HEX_write_ASM(HEX1, read_slider_switches_ASM());
			}

			if(read_PB_data_ASM() == 4){
				HEX_write_ASM(HEX2, read_slider_switches_ASM());
			}

			if(read_PB_data_ASM() == 8){
				HEX_write_ASM(HEX3, read_slider_switches_ASM());
			}

		} 
	}
return 0;
}



/*							//Part3 - timer
int main() {
//	timer timer
	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0;
	hps_tim.timeout = 10000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	HPS_TIM_config_ASM(&hps_tim); // Config timer 0
	
	// timer for pushbutton polling
	HPS_TIM_config_t hps_tim_pb;
	hps_tim_pb.tim = TIM1;
	hps_tim_pb.timeout = 5000;
	hps_tim_pb.LD_en = 1;
	hps_tim_pb.INT_en = 1;
	hps_tim_pb.enable = 1;
	HPS_TIM_config_ASM(&hps_tim_pb); // Config timer 1

	// init varaible 
	int millisec = 0; 
	int sec = 0;
	int min = 0; 
	int  timerstart = 0;	// work as a boolean variable to control the timer
	while (1) {
		// Checks if timer was started
		if (HPS_TIM_read_INT_ASM(TIM0) && timerstart) {
			HPS_TIM_clear_INT_ASM(TIM0);
			millisec += 10; 					// Timer increments every 10 milliseconds - determined by the board working frequence
			// 1 sec = 1000 ms, reset when millisec = 1000
			if (millisec >= 1000) {
				millisec = 0;
				sec++;
				// 1 min = 60s, reset when sec=60
				if (sec >= 60) {
					sec = 0;
					min++;
					// 1 hr = 60 mins, reset when min=60, since we will not have hour display, simply reset to 0
					if (min >= 60) {
						min = 0;
					}
				}
			}
			// hex display for the timer millisec <-> hex0-1, sec <-> hex2-3, min <-> hex4-5
			HEX_write_ASM(HEX0, (millisec % 100) / 10);		// Milli increments in 10 microseconds so we must modulo and divide by 10 to get the digit at 0.01 s --hex0
			HEX_write_ASM(HEX1, millisec / 100);			// Divide Milli by 100 to get 0.1s digit --hex1
			HEX_write_ASM(HEX2, sec % 10);					// Modulo by 10 to get the left digit -- hex2
			HEX_write_ASM(HEX3, sec / 10);					// Divide by 10 to get the right digit -- hex3
			HEX_write_ASM(HEX4, min % 10);					// Same for minutes --hex4
			HEX_write_ASM(HEX5, min / 10);					// hex5
		}

		//Pushbuttons polling
		if (HPS_TIM_read_INT_ASM(TIM1)) {
			int pushbutton = 0xF & read_PB_data_ASM();		// read user action
			
			//Start 
			if ((pushbutton & 8) && (!timerstart)) 			// start push button is pressed and the timer is not start
				timerstart = 1;								// set timerstart=1 and start timer
			//Stop	
			else if ((pushbutton & 4) && (timerstart)) 		// pause button pressed & timer already started
				timerstart = 0;								// to pause, set timerstart=0
			//Reset 
			else if (pushbutton & 2) {						// reset button pressed, we don't care if the timer is started or paused
															// reset all varaible to 0
				millisec = 0;
				sec = 0;
				min = 0;
				timerstart = 0;
				// reset hex display
				HEX_write_ASM(HEX0, 0);
				HEX_write_ASM(HEX1, 0);
				HEX_write_ASM(HEX2, 0);
				HEX_write_ASM(HEX3, 0);
				HEX_write_ASM(HEX4, 0);
				HEX_write_ASM(HEX5, 0);
				// HEX_write_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5, 0); // can be written for each hex separatedly
			}
		}
	}
	return 0;
}
*/
 

/*								//Part4 - interrupt
int main() {

int_setup(2, (int[]) {73, 199});                     // 199 <-> HPS timer 0, 73 <-> FPGA push button keys 
	enable_PB_INT_ASM(PB3 | PB2 | PB1);

	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0;
	hps_tim.timeout = 10000;
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	HPS_TIM_config_ASM(&hps_tim);

	int millisec = 0; 
	int sec = 0;
	int min = 0; 
	int  timerstart = 0;

	// the logic for timer stays the same as part 3, the additional check is with the corresponding flag
	while (1) {
		if (hps_tim0_int_flag && timerstart) {		// Check if the TIM0 flag is on to run timer
			hps_tim0_int_flag = 0;					// Reset flag of TIM0
			millisec += 10; 

			if (millisec >= 1000) {
				millisec = 0;
				sec++;
				if (sec >= 60) {
					sec = 0;
					min++;
					if (min >= 60) {
						min = 0;
					}
				}
			}
			// reset display
			HEX_write_ASM(HEX0, (millisec % 100) / 10);
			HEX_write_ASM(HEX1, millisec / 100);
			HEX_write_ASM(HEX2, sec % 10);
			HEX_write_ASM(HEX3, sec / 10);
			HEX_write_ASM(HEX4, min % 10);
			HEX_write_ASM(HEX5, min / 10); 
		}
		
		// The pushbutton flag corresponds to which button is pressed 
		// all flag values are set in the ISRs.s file, same logic with timer without interrupt
		if (pb_int_flag != 0){
			// Start
			if (pb_int_flag == 8 && !timerstart) 			// instead of checking the pushbutton action with a specific value, we check the flag value
				timerstart = 1;		
			// Stop
			else if (pb_int_flag == 4 && timerstart) 
				timerstart = 0;
			// Reset
			else if (pb_int_flag == 2) {
				millisec = 0;
				sec = 0;
				min = 0;
				timerstart = 0;
				HEX_write_ASM(HEX0, 0);
				HEX_write_ASM(HEX1, 0);
				HEX_write_ASM(HEX2, 0);
				HEX_write_ASM(HEX3, 0);
				HEX_write_ASM(HEX4, 0);
				HEX_write_ASM(HEX5, 0);
			}
			pb_int_flag = 0;		// Reset pushbutton flag to default
		}
	}

	return 0;
}
*/

	
