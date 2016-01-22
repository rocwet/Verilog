/* NAME					|	iD_iD.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  pipelined stage 1
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	clk 					|  IN						|  the clk: perform the tasks in single cycle
	reset 				|  IN						|  the reset signal
	instrIn 				|  IN	[31:0]			|  instructions being read
	instrOut 			|  OUT [31:0]			|  instructions being stored
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 4: MIPS Pipelined CPU
	CLASS					| EE 471
	DATE					| 03/13/2015
	#################################################################################################
*/
module iF_iD(instrOut, instrIn, clk, reset);

	output [31:0] instrOut;
	input [31:0] instrIn;
	input clk, reset;
	
	thirtyTwoBitRegister in32(.out(instrOut), .in(instrIn), .clk, .reset);
	
endmodule
