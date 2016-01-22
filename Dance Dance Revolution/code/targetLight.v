// the rowRegularLight module will maintain the flow of lights in a column through rows
// PARAMETERS
// CLOCK        = clock
// RESET        = reset signal
// PRELIGHT     = light before current (this one)
// LIGHTON      = this current light
module targetLight (CLOCK, RESET, GOTCHA, PRELIGHT, LIGHTON);

	// ports
	input CLOCK, RESET, PRELIGHT, GOTCHA;
	output reg LIGHTON;
	
	// stateholding varaibles
	wire PS;
	reg NS;
	
	// variables
	parameter A = 0, B = 1;
	
	// state machine logic
	always @ (PS)
		case(PS)
			A: if(PRELIGHT) NS = B;
				else NS = A;
			B: if(PRELIGHT) NS = B;
				else NS = A;
			default: NS = 1'bx;
		endcase
	
	// output logic
	always @ (PS)
		case(PS)
			A: LIGHTON = 0;
			B: LIGHTON = 1;
		endcase
	
	// stateholding
	D_FF msb(PS, NS, RESET | GOTCHA, CLOCK);
	
endmodule