// The clock_divider module will change the clock speed of a given clock to a different clock frequency
// PARAMETER
// clock             = inputted clock
// divided_clocks    = output clock with changed frequency
// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
	
	// inputs
	input clock;
	
	// output
	output [31:0] divided_clocks;
	
	// variable
	reg [31:0] divided_clocks;
	
	// code
	initial
	divided_clocks = 0;
	always @(posedge clock)
	divided_clocks = divided_clocks + 1;
	
endmodule