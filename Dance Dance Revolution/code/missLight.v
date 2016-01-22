// the rowRegularLight module will maintain the flow of lights in a column through rows
// PARAMETERS
// CLOCK        = clock
// RESET        = reset signal
// PRELIGHT     = light before current (this one)
// LIGHTON      = this current light
module missLight (CLOCK, RESET, NUM, PRELIGHT, MISS);

	// ports
	input CLOCK, RESET, PRELIGHT, NUM;
	output reg MISS;
	
	// stateholding varaibles
	wire PS;
	reg NS;
	
	// variables
	parameter A = 0, B = 1;
	
	// state machine logic
	always @ (CLOCK)
		case(PS)
			A: if(PRELIGHT & NUM) NS = B;
				else NS = A;
			B: NS = A;
			default: NS = 1'bx;
		endcase
	
	// output logic
	always @ (PS)
		case(PS)
			A: MISS = 0;
			B: MISS = 1;
		endcase
	
	// stateholding
	D_FF msb(PS, NS, RESET, CLOCK);
	
endmodule