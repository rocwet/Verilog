// the scoreTracker module will keep track of the score
// PARAMETER
// CLOCK           = cloCK
// RESET           = reset signal
// KEY             = key press
// ROW1            = the missed row
// ROW2            = the main target row
// CORRECT         = conditions met then, CORRECT signal is outputed  = +2
// WRONG           = conditions met then, WRONG signal is outputed    = -2
// OFF             = conditions met then, OFF signal is outputed      = +1
// GOTTEN2         = signal if the ROW2 LED is gotten
// GOTTEN1         = signal if the ROW1 LED is gotten
module scoreTracker (CLOCK, RESET, KEY, ROW1, ROW2, CORRECT, WRONG, OFF);
	
	// ports
	input CLOCK, RESET, KEY, ROW1, ROW2;
	output reg CORRECT, WRONG, OFF;
	
	// stateholding variables
	wire [1:0] PS;
	reg [1:0] NS;
	
	// variables
	parameter[1:0] nothing = 2'b00 , plusOne = 2'b01, plusTwo = 2'b10, minusTwo = 2'b11;
 
	// next state logic
	always @(PS or ROW1 or ROW2 or KEY)
		case(PS)
			nothing: if(ROW2 & KEY) NS = plusTwo;
						else if (ROW1 & KEY) NS = plusOne;
						else if (KEY & ~ROW1 | KEY & ~ROW2 ) NS = minusTwo;
					   else NS = nothing;
			plusOne: if(ROW2 & KEY) NS = plusTwo;
						else if (ROW1 & KEY) NS = plusOne;
						else if (KEY & ~ROW1 | KEY & ~ROW2 ) NS = minusTwo;
						else NS = nothing;
			plusTwo: if(ROW2 & KEY) NS = plusTwo;
						else if (ROW1 & KEY) NS = plusOne;
						else if (KEY & ~ROW1 | KEY & ~ROW2 ) NS = minusTwo;
						else NS = nothing;
			minusTwo: if(ROW2 & KEY) NS = plusTwo;
						 else if (ROW1 & KEY) NS = plusOne;
						 else if (KEY & ~ROW1 | KEY & ~ROW2 ) NS = minusTwo;
						 else NS = nothing;
				
			default: NS = 2'bxx;
		endcase
		 
	// output logic
	always @(PS)
		case(PS)
			nothing:begin
				CORRECT = 0;
				WRONG = 0;
				OFF = 0;
				end
			plusOne:begin
				CORRECT = 0;
				if(ROW2 & ~KEY) WRONG = 1;
				else WRONG = 0;
				OFF = 1;
				end
			plusTwo: begin
				CORRECT = 1;
				if(ROW1 & ~KEY) WRONG = 1;
				else WRONG = 0;
				OFF = 0;
				end
			minusTwo: begin
				CORRECT = 0;
				WRONG = 1;
				OFF = 0;
				end
			default:begin
				CORRECT = 1'bx;
				WRONG = 1'bx;
				OFF = 1'bx;

				end
		endcase
		  
		// stateholding
		D_FF a (PS[0], NS[0], RESET, CLOCK); 
		D_FF b (PS[1], NS[1], RESET, CLOCK); 
		
endmodule