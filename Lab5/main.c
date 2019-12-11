#include "./drivers/inc/vga.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/slider_switches.h"

 /*        // PART 0 
int main(){
	int signal = 0x00FFFFFF;
	int samples = 0 ;
	while(1) { 
		if (audio_write_data_ASM(signal, signal)) {  // checks if the write was successful to both FIFOS
			samples++;	 
																	 
			if (samples > 240) {
				samples = 0;
				if (signal == 0x00000000) {
					signal = 0x00FFFFFF;
				} else {
					signal = 0x00000000;
				}
			}
		}
	} 
return 0;
}
*/
//------------------------------------------------------------------------------------------


int notesPlayed[8] = {};
float frequencies[] = {130.813, 146.832, 164.814, 174.614, 195.998, 220.000, 246.942, 261.626};
double getSample(float freq, int t) {
	int signal;
	int index = (((int)freq) * t)%48000;    // index  = (f*t) mod 48000
	float diff = (freq * t) - ((int)(freq * t));
	if (diff = 0) {
	 signal = sine[index];			
	}
    else {
	 signal =  (1.0 - diff) * sine[index] + diff * sine[index+1];
	}
	return signal;
}

//This generates the signal from the samples
double makeSignal(int* notePlayed, int t){
	int i;
	double sumOfSamples = 0.0;
	
	//iterate through the notes that the user entered
	for(i = 0;i<8;i++){
		//if user entered a note then add it
		if(notePlayed[i] == 1){
			sumOfSamples += getSample(frequencies[i],t);
		}
	}
	return sumOfSamples;
}
int main() {
	// Setup timer
	int_setup(1, (int []){199});
	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0; 
	hps_tim.timeout = 20; 
	hps_tim.LD_en = 1;
	hps_tim.INT_en = 1; 
	hps_tim.enable = 1; 

	HPS_TIM_config_ASM(&hps_tim);
	 	
	char keyPressed = 1; 
	
	// counter for signal
	int t = 0; 


	char a; 
	char amplitude = 1; 
	double signalSum = 0.0; 
	while(1) {
			if(read_slider_switches_ASM()!=0){
				if(read_ps2_data_ASM(&a)){
					switch(a){
						case 0x1C:  //If A is pressed
						if(keyPressed == 1){
							notesPlayed[0] = 1;
						}else{
							notesPlayed[0] = 0;
							keyPressed = 1;
						}break;

						case 0x1B:
						if(keyPressed == 1){
							notesPlayed[1] = 1;
						}else{
							notesPlayed[1] = 0;
							keyPressed = 1;
						}break;

						case 0x23:
						if(keyPressed == 1){
							notesPlayed[2] = 1;

						}else{
							notesPlayed[2] = 0;
							keyPressed = 1;
						}break;

						case 0x2B:
						if(keyPressed == 1){
							notesPlayed[3] = 1;

						}else{
							notesPlayed[3] = 0;
							keyPressed = 1;
						}break;

						case 0x3B:
						if(keyPressed == 1){
							notesPlayed[4] = 1;
						
						}else{
							notesPlayed[4] = 0;
							keyPressed = 1;
						}break;

						case 0x42:
						if(keyPressed == 1){
							notesPlayed[5] = 1;
							
						}else{
							notesPlayed[5] = 0;
							keyPressed = 1;
						}break;

						case 0x4B:
						if(keyPressed == 1){
							notesPlayed[6] = 1;
						}else{
							notesPlayed[6] = 0;
							keyPressed = 1;
						}break;

						case 0x4C:
						if(keyPressed == 1){
							notesPlayed[7] = 1;
						}else{
							notesPlayed[7] = 0;
							keyPressed = 1;
						}break;

						case 0xF0:
							keyPressed = 0;
							break;

						case 0x43: //'I'
						if(keyPressed ==1){
							if(amplitude <10){
								amplitude++;
							}
						}break;

						case 0x2D: // 'R'
						if(keyPressed == 1){
							if(amplitude !=0){
								amplitude--;
							}
						}
						default:
							keyPressed = 0;
					}
				}
			}
			signalSum = makeSignal(notesPlayed, t); 

			signalSum = amplitude * signalSum; // volume control
		
			
			if(hps_tim0_int_flag == 1) {
				hps_tim0_int_flag = 0;
				audio_write_data_ASM(signalSum, signalSum);
				t++;
			}
			// Reset signal
			signalSum = 0;
			// Reset counter to 0 when t= 48000
			if(t==48000){
				t=0;
			}
	
	} //end of WHILE LOOP

	return 0;
}

