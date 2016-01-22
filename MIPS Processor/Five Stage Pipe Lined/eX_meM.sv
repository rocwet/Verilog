/* NAME					|	eX_meM.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  pipelined stage 3
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	clk 					|  IN						|  the clk: perform the tasks in single cycle
	reset 				|  IN						|  the reset signal
	instrIn 				|  IN	[31:0]			|  instructions being read
	DbIn 					|  IN [31:0]			|  DbIn
	AwIn					|  IN [4:0]          |  AwIn 
	RegWrIn				|  IN						|  RegWrIn
	MemWrIn				|  IN 					| 	MemWrIn	
	MemToRegIn			|  IN 					| 	MemToRegIn
	RegDestIn			|  IN						|  RegDestIn
	ALUIn					|  IN [31:0]			|  ALUIn
	ALUOut				|  OUT [31:0]			|  ALUOut
	RegDestOut			|  OUT					|  RegDestOut
	MemToRegOut			|  OUT					| 	MemToRegOut
	MemWrOut				|  OUT 					| 	MemWrOut	
	DbOut					|  OUT [31:0]        |  DbOut 
	AwOut					|  OUT [4:0]         |  AwOut 
	RegWrOut				|  OUT  		         |  RegWrOut
	instrOut 			|  OUT [31:0]			|  instructions being stored
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 4: MIPS Pipelined CPU
	CLASS					| EE 471
	DATE					| 03/13/2015
	#################################################################################################
*/
module eX_meM(ALUOut, DbOut, AwOut, ALUIn, DbIn, AwIn, clk, reset, RegWrOut, MemWrOut, MemToRegOut,
					RegWrIn, MemWrIn, MemToRegIn, instrIn, instrOut, RegDestOut, RegDestIn);

	output [31:0] ALUOut, DbOut, instrOut;
	output [4:0] AwOut;
	output RegWrOut, MemWrOut, MemToRegOut, RegDestOut; 
	input [31:0] ALUIn, DbIn, instrIn;
	input [4:0] AwIn;
	input clk, reset, RegWrIn, MemWrIn, MemToRegIn, RegDestIn;
	
	thirtyTwoBitRegister in32(.out(instrOut), .in(instrIn), .clk, .reset);
	thirtyTwoBitRegister alu32 (.out(ALUOut), .in(ALUIn), .clk, .reset);
	thirtyTwoBitRegister db32(.out(DbOut), .in(DbIn), .clk, .reset);

	fiveBitRegister aw5(.out(AwOut), .in(AwIn), .clk, .reset);
	
	D_FF RegWr (.q(RegWrOut), .d(RegWrIn), .reset, .clk);
	D_FF MemWr (.q(MemWrOut), .d(MemWrIn), .reset, .clk);
	D_FF MemToReg (.q(MemToRegOut), .d(MemToRegIn), .reset, .clk);
	D_FF RegDest (.q(RegDestOut), .d(RegDestIn), .reset, .clk);
	
endmodule
