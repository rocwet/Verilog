/* NAME					|	decode5to32.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  Converts 5 bit data to 32 bit data
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT [31:0]		|	32-bit interpretation of the input
	IN						|	INPUT	 [4:0]		|	Data to be decoded, from 5 to 32 bit
	ENABLE				|	INPUT  				| 	Determines if the decoder is on or off
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module decode5to32(IN, OUT, ENABLE);
	
	// ports
	input [4:0] IN;
	input ENABLE;
	output [31:0] OUT;
	
	// wire
	wire [3:0] dec2to4OUT;
	
	// 3:8 decoders
	decode3to8 d38_0 (.IN(IN[2:0]), .OUT(OUT[7:0]),		.ENABLE(dec2to4OUT[0]));
	decode3to8 d38_1 (.IN(IN[2:0]), .OUT(OUT[15:8]), 	.ENABLE(dec2to4OUT[1]));
	decode3to8 d38_2 (.IN(IN[2:0]), .OUT(OUT[23:16]), 	.ENABLE(dec2to4OUT[2]));
	decode3to8 d38_3 (.IN(IN[2:0]), .OUT(OUT[31:24]), 	.ENABLE(dec2to4OUT[3]));
	
	// 2:4 decoder
	decode2to4 d24_0 (.IN(IN[4:3]), .OUT(dec2to4OUT), 	.ENABLE(ENABLE));
	
endmodule


// test
module decode5to32_testbench();
	reg [4:0] IN;
	reg ENABLE;
	wire [31:0] OUT;

	decode5to32 dut (.IN, .OUT, .ENABLE);

	integer i;
	initial begin
		for(i=0; i<64; i++) begin
			{IN, ENABLE} = i; #10;
		end
	end

endmodule