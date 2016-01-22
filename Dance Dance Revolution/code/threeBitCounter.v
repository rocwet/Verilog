// The threeBitCounter module will count from 0 to 7 every clock cycle
// PARAMETERS
// CLOCK     = clock
// RESET     = reset signal
// OUT       = current number in the cycle 
module threeBitCounter(CLOCK, RESET, OUT);

	// ports
	input CLOCK, RESET;
	output reg [3:0] OUT;
	
	// variables
	wire [2:0] PS;
	reg  [2:0] NS;
	
	always @ (PS)
		begin
			NS[0] = ~PS[0];
			NS[1] =  PS[1] ^ PS[0];
			NS[2] =  PS[2] ^ (PS[1]&PS[0]);
		end
		
	always @ (PS)
		OUT = PS;
		
	// state holding
	D_FF stage0 (PS[0], NS[0], RESET, CLOCK);
	D_FF stage1 (PS[1], NS[1], RESET, CLOCK);
	D_FF stage2 (PS[2], NS[2], RESET, CLOCK);
	
endmodule
		
		