/* NAME					|	fiveBitRegister.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  storing registers with dff in pipelined stage
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	in 					|  IN [4:0]			   |  input storing unit
	clk  	 				|  IN				  	   |  clk
	reset					|  IN			         |  reset signal
	out					|  OUT [4:0]         |  output storing unit
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 4: MIPS Pipelined CPU
	CLASS					| EE 471
	DATE					| 03/13/2015
	#################################################################################################
*/ 
module fiveBitRegister(out, in, clk, reset);

	output [4:0] out;
	input [4:0] in;
	input clk, reset;
	
	genvar a;
	generate
		for(a = 0; a < 5; a++) begin: eachBit
			D_FF d0 (.q(out[a]), .d(in[a]), .reset, .clk);
		end
	endgenerate
	
endmodule
