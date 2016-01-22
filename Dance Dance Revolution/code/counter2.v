module counter2(CLOCK, RESET, UP, OUT, NEXT);

	// ports
	input CLOCK, RESET, UP;
	output [2:0] OUT;
	output reg NEXT;
	
	// variables
	wire [2:0] PS;
	reg [2:0] NS;
	reg [2:0] num;
	
	// assignments
	assign OUT = num;
	
							

	// next state logic
	always @(UP)
		begin
		NS[0] =  (PS[0] ^ UP);
		NS[1] =  (PS[1]) ^ (PS[0]&UP);
		NS[2] =  (PS[2]) ^ (PS[1]&PS[0]&UP);

//		NS[0] = (PS[0] ^ UP) | (PS[2]&PS[1]&PS[0]&UP) ;
//		NS[1] = (PS[1]&(~PS[0] | ~UP | PS[2])) | (~PS[1]&PS[0]&UP);
//		NS[2] = (PS[2]) | (~PS[2]&PS[1]&PS[0]&UP);


		end
		
	// output logic
	always @(PS)
		begin
		num = PS;
		NEXT = PS[2]&PS[1]&PS[0]&UP;
		end
		
	// state holding
	D_FF stage0 (PS[0], NS[0], RESET, CLOCK);
	D_FF stage1 (PS[1], NS[1], RESET, CLOCK);
	D_FF stage2 (PS[2], NS[2], RESET, CLOCK);

endmodule