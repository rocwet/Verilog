// The nineBitLFSR create a "random" 9 bit number every clock cycle
// PARAMETER
// Clock        = clock cycle
// reset        = reset signal
// out          = the "random" 9 bit number
module threeBitLFSR(Clock, reset, out);

	// ports
	input Clock, reset;
	output reg [2:0] out;
	
	// variables
	wire [2:0] PS;
	
	// output logic
	always @ (PS)
		out = PS;

	// cascaded flip flops
	D_FF stage0 (PS[0], ~(PS[0]^PS[1]), reset, Clock);
	D_FF stage1 (PS[1], PS[0], reset, Clock);
	D_FF stage2 (PS[2], PS[1], reset, Clock);


endmodule