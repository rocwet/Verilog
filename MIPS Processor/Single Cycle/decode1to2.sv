/* NAME					|	decode1to2.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  Converts 1 bit data to 2 bit data
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT [1:0]		|	2-bit interpretation of the input
	IN						|	INPUT	 				|	Data to be decoded, from 1 to 2 bit
	ENABLE				|	INPUT  				| 	Determines if the decoder is on or off
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module decode1to2(IN, OUT, ENABLE);
	
	// ports
	input IN;
	input ENABLE;
	output [1:0] OUT;
	
	// wires
	wire notIN;
	
	// gate logic
	not notInput (notIN, IN);
	and output0 (OUT[0], notIN, ENABLE);
	and output1 (OUT[1], IN, ENABLE);
	
endmodule


// test
module decode1to2_testbench();
	reg IN, ENABLE;
	wire [1:0] OUT;

	decode1to2 dut (.IN, .OUT, .ENABLE);

	integer i;
	initial begin
		for(i=0; i<8; i++) begin
			{IN, ENABLE} = i; #10;
		end
	end
endmodule 