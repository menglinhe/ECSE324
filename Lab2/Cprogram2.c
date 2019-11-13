int main() {
	
	int a[5] = {1, 20, 3, 4, 5};   //array of numbers
	
	int min_val;                  // min_value initialized
	min_val = a[0];				  // min_value assigned the first number in the array
	int i;						  // i initialized
				
	for (i=0; i < 5; i++){		  // For loop that iterates through the array
		if(a[i] < min_val){       // checks if the number in the array is less than the min_value
			min_val = a[i];		 //  if yes, then min_value changed to whatever the a[i] was
		}
	}
	return min_val;              // min_value returned
}
