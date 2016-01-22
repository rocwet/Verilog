// The inputS module will define the rules for button presses for tug of war
// No presses        = No presses
// Single Presses    = Single Press
// Held Presses      = Single Press
// PARAMETER     
// Clock             = clock cyle
// reset             = reset signal
// button            = received button press
// BT                = new button signal w/ implemented rules
module inputRules(Clock, reset, button, BT);

	// ports
	input Clock, reset, button;
	output BT;
	
	// variables
	reg btn;
	parameter [1:0]  A = 2'b00, B = 2'b01, C = 2'b10;
	wire [1:0] PS;
	reg [1:0] NS;
	
	// assignemnts
	assign BT = btn;
	
	// next state logic
	always @(PS or button)
		case(PS)
			A:	if(button) NS = B;
				else NS = A;
			B: if(button) NS = C;
				else NS = A;
			C: if(button) NS = C;
				else NS = A;
		endcase
		
	// output logic
	always @ (PS)
		case(PS)
			A: btn = 0;
			B: btn = 1;
			C: btn = 0;
		endcase
	
	// state holding changing
	D_FF msb (PS[0], NS[0], reset, Clock);
	D_FF lsb (PS[1], NS[1], reset, Clock);
	
endmodule