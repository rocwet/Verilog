// The D_FF module is a D-Latch Flip Flop
// PARAMETER
//	q          = output
// d          = input
// reset      = reset q to 0
// clk        = clock
module D_FF (q, d, reset, clk);
	
	// output
	output reg q;
	
	// input
	input d, reset, clk;
	
	// condition
	always @(posedge clk or posedge reset) 
	if (reset)
		q = 0; // On reset, set to 0
	else
		q = d; // Otherwise out = d
	
endmodule