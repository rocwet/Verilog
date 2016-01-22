// The nineBitLFSR create a "random" 9 bit number every clock cycle
// PARAMETER
// Clock        = clock cycle
// reset        = reset signal
// out          = the "random" 9 bit number
module nineBitLFSR(Clock, reset, out);

	// ports
	input Clock, reset;
	output reg [8:0] out;
	
	// variables
	wire [8:0] PS;
	
	// output logic
	always @ (PS)
		out = PS;

	// cascaded flip flops
	D_FF stage0 (PS[0], ~(PS[4]^PS[8]), reset, Clock);
	D_FF stage1 (PS[1], PS[0], reset, Clock);
	D_FF stage2 (PS[2], PS[1], reset, Clock);
	D_FF stage3 (PS[3], PS[2], reset, Clock);
	D_FF stage4 (PS[4], PS[3], reset, Clock);
	D_FF stage5 (PS[5], PS[4], reset, Clock);
	D_FF stage6 (PS[6], PS[5], reset, Clock);
	D_FF stage7 (PS[7], PS[6], reset, Clock);
	D_FF stage8 (PS[8], PS[7], reset, Clock);

endmodule