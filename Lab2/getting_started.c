  
extern int MIN_2(int x, int y);

int main() {
	int a[5] = {1, 20, 3, 4, 5};  //array of numbers
	
	int min_val;				 //min_value initialized
	min_val = a[0];				// min_value =  first value inside the array
	int i;                      // i initialized
	
	for (i=1; i < 5; i++){		// for loop that iterates through the array , starting from the second number inside the array
		int b = a[i];           // b  = a[i]  
		int a = min_val;        // a = min_value
		int c = MIN_2(a, b);    // c = min out of a or b
		min_val = c;            // min_value = minimum of a and b
		}
	return min_val;   		  // min_val returned
}
