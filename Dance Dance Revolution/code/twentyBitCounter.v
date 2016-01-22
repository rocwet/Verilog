// the twentyBitCounter module will count up to 2^20, roughy a million and is used to divide time to 1 Hz
// PARAMETER
// CLOCK    = cloCK
// RESET    = reset signal
// OUT      = when the counter is at 0.
module twentyBitCounter(CLOCK, RESET, S, VAL, OUT);

	// ports
	input CLOCK, RESET;
	input [2:0] VAL;
	input [19:0] S;
	output reg  OUT;
	
	// stateholding variables
	wire [19:0] PS;
	reg [19:0] NS;
	
	// counter logic
	always @ (PS)
		begin
			NS[0]   = ~PS[0];
			NS[1]   = PS[1]  ^ (PS[0]);
			NS[2]   = PS[2]  ^ (PS[1]&PS[0]);
			NS[3]   = PS[3]  ^ (PS[2]&PS[1]&PS[0]);
			NS[4]   = PS[4]  ^ (PS[3]&PS[2]&PS[1]&PS[0]);
			NS[5]   = PS[5]  ^ (PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[6]   = PS[6]  ^ (PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[7]   = PS[7]  ^ (PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[8]   = PS[8]  ^ (PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[9]   = PS[9]  ^ (PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[10]  = PS[10] ^ (PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[11]  = PS[11] ^ (PS[10]&PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[12]  = PS[12] ^ (PS[11]&PS[10]&PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[13]  = PS[13] ^ (PS[12]&PS[11]&PS[10]&PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[14]  = PS[14] ^ (PS[13]&PS[12]&PS[11]&PS[10]&PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[15]  = PS[15] ^ (PS[14]&PS[13]&PS[12]&PS[11]&PS[10]&PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[16]  = PS[16] ^ (PS[15]&PS[14]&PS[13]&PS[12]&PS[11]&PS[10]&PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[17]  = PS[17] ^ (PS[16]&PS[15]&PS[14]&PS[13]&PS[12]&PS[11]&PS[10]&PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[18]  = PS[18] ^ (PS[17]&PS[16]&PS[15]&PS[14]&PS[13]&PS[12]&PS[11]&PS[10]&PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
			NS[19]  = PS[19] ^ (PS[18]&PS[17]&PS[16]&PS[15]&PS[14]&PS[13]&PS[12]&PS[11]&PS[10]&PS[9]&PS[8]&PS[7]&PS[6]&PS[5]&PS[4]&PS[3]&PS[2]&PS[1]&PS[0]);
		end
	
	always @ (PS or VAL)
		begin
			if(VAL == 0) OUT = (PS == S);
			else if (VAL == 1) OUT = (PS == S) | (PS == 524288);
			else OUT = (PS == S);
		
	end
		
	// state holding
	D_FF stage0 (PS[0], NS[0], RESET, CLOCK);
	D_FF stage1 (PS[1], NS[1], RESET, CLOCK);
	D_FF stage2 (PS[2], NS[2], RESET, CLOCK);
	D_FF stage3 (PS[3], NS[3], RESET, CLOCK);
	D_FF stage4 (PS[4], NS[4], RESET, CLOCK);
	D_FF stage5 (PS[5], NS[5], RESET, CLOCK);
	D_FF stage6 (PS[6], NS[6], RESET, CLOCK);
	D_FF stage7 (PS[7], NS[7], RESET, CLOCK);
	D_FF stage8 (PS[8], NS[8], RESET, CLOCK);
	D_FF stage9 (PS[9], NS[9], RESET, CLOCK);
	D_FF stage10 (PS[10], NS[10], RESET, CLOCK);
	D_FF stage11 (PS[11], NS[11], RESET, CLOCK);
	D_FF stage12 (PS[12], NS[12], RESET, CLOCK);
	D_FF stage13 (PS[13], NS[13], RESET, CLOCK);
	D_FF stage14 (PS[14], NS[14], RESET, CLOCK);
	D_FF stage15 (PS[15], NS[15], RESET, CLOCK);
	D_FF stage16 (PS[16], NS[16], RESET, CLOCK);
	D_FF stage17 (PS[17], NS[17], RESET, CLOCK);
	D_FF stage18 (PS[18], NS[18], RESET, CLOCK);
	D_FF stage19 (PS[19], NS[19], RESET, CLOCK);
	
endmodule

	
		
	
