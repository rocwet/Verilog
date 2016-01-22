/* NAME					|	TwoBitRegister.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  storing registers with dff in pipelined stage
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	in 					|  IN [1:0]			   |  input storing unit
	clk  	 				|  IN				  	   |  clk
	reset					|  IN			         |  reset signal
	out					|  OUT [1:0]         |  output storing unit
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 4: MIPS Pipelined CPU
	CLASS					| EE 471
	DATE					| 03/13/2015
	#################################################################################################
*/ 
module TwoBitRegister(out, in, clk, reset);

	output [1:0] out;
	input [1:0] in;
	input clk, reset;
	
	genvar a;
	generate
		for(a = 0; a < 2; a++) begin: eachBit
			D_FF d0 (.q(out[a]), .d(in[a]), .reset, .clk);
		end
	endgenerate
	
endmodule
