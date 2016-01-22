/* NAME					|	decode3to8.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  Converts 3 bit data to 8 bit data
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT [7:0]		|	8-bit interpretation of the input
	IN						|	INPUT	 [2:0]		|	Data to be decoded, from 3 to 8 bit
	ENABLE				|	INPUT  				| 	Determines if the decoder is on or off
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module decode3to8(IN, OUT, ENABLE);
	
	// ports
	input [2:0] IN;
	input ENABLE;
	output [7:0] OUT;
	
	// wires
	wire [1:0] dec1to2OUT;

	// 1:2 decoders
	decode1to2 d12_0 (.IN(IN[2]), .OUT(dec1to2OUT), .ENABLE(ENABLE));
	
	// 2:4 decoder
	decode2to4 d24_0 (.IN(IN[1:0]), .OUT(OUT[3:0]), .ENABLE(dec1to2OUT[0]));
	decode2to4 d24_1 (.IN(IN[1:0]), .OUT(OUT[7:4]), .ENABLE(dec1to2OUT[1]));

endmodule


// test
module decode3to8_testbench();
	reg [2:0] IN;
	reg ENABLE;
	wire [7:0] OUT;

	decode3to8 dut (.IN, .OUT, .ENABLE);

	integer i;
	initial begin
		for(i=0; i<32; i++) begin
			{IN, ENABLE} = i; #10;
		end
	end
endmodule 