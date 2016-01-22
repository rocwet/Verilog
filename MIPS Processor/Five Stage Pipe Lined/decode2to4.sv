/* NAME					|	decode2to4.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  Converts 2 bit data to 4 bit data
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT [3:0]		|	4-bit interpretation of the input
	IN						|	INPUT	 [1:0]		|	Data to be decoded, from 2 to 4 bit
	ENABLE				|	INPUT  				| 	Determines if the decoder is on or off
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module decode2to4(IN, OUT, ENABLE);
	
	// ports
	input [1:0] IN;
	input ENABLE;
	output [3:0] OUT;
	
	// wires
	wire [1:0] dec1to2OUT;

	// 1:2 decoders
	decode1to2 d12_0 (.IN(IN[1]), .OUT(dec1to2OUT), .ENABLE(ENABLE));
	decode1to2 d12_1 (.IN(IN[0]), .OUT(OUT[1:0]), .ENABLE(dec1to2OUT[0]));
	decode1to2 d12_2 (.IN(IN[0]), .OUT(OUT[3:2]), .ENABLE(dec1to2OUT[1]));

endmodule


// test
module decode2to4_testbench();
	reg [1:0] IN;
	reg ENABLE;
	wire [3:0] OUT;

	decode2to4 dut (.IN, .OUT, .ENABLE);

	integer i;
	initial begin
		for(i=0; i<8; i++) begin
			{IN, ENABLE} = i; #10;
		end
	end
endmodule 