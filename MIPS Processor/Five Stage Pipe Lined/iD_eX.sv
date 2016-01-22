/* NAME					|	iD_eX.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  pipelined stage 2
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	clk 					|  IN						|  the clk: perform the tasks in single cycle
	reset 				|  IN						|  the reset signal
	instrIn 				|  IN	[31:0]			|  instructions being read
	DaIn 					|  IN [31:0]			|  DaIn
	DbIn 					|  IN [31:0]			|  DbIn
	RegWrIn				|  IN						|  RegWrIn
	ALUcntrlIn			|  IN [1:0]				| 	ALUcntrlIn	
	ALUSrcIn				|  IN 					| 	ALUSrcIn	
	MemWrIn				|  IN 					| 	MemWrIn	
	MemToRegIn			|  IN 					| 	MemToRegIn
	RegDestIn			|  IN						|  RegDestIn
	RegDestOut			|  OUT					|  RegDestOut
	MemToRegOut			|  OUT					| 	MemToRegOut
	MemWrOut				|  OUT 					| 	MemWrOut	
	ALUSrcOut			|  OUT 					|  ALUSrcOut
	ALUcntrlOut			|  OUT [1:0]			|  ALUcntrlOut
	DaOut					|  OUT [31:0]        |  DaOut 
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
module iD_eX(DaOut, DbOut, AwOut, DaIn, DbIn, AwIn, clk, reset, RegWrOut, ALUSrcOut, ALUcntrlOut, MemWrOut, 
					MemToRegOut, RegWrIn, ALUSrcIn, ALUcntrlIn, MemWrIn, MemToRegIn, instrIn, instrOut, RegDestOut, RegDestIn);

	output [31:0] DaOut, DbOut, instrOut;
	output [4:0] AwOut;
	output [1:0] ALUcntrlOut; 
	output RegWrOut, ALUSrcOut, MemWrOut, MemToRegOut, RegDestOut; 
	input [31:0] DaIn, DbIn, instrIn;
	input [4:0] AwIn;
	input [1:0] ALUcntrlIn; 
	input clk, reset, RegWrIn, ALUSrcIn, MemWrIn, MemToRegIn, RegDestIn;
	
	thirtyTwoBitRegister in32(.out(instrOut), .in(instrIn), .clk, .reset);
	thirtyTwoBitRegister da32(.out(DaOut), .in(DaIn), .clk, .reset);
	thirtyTwoBitRegister db32(.out(DbOut), .in(DbIn), .clk, .reset);
	
	fiveBitRegister aw5(.out(AwOut), .in(AwIn), .clk, .reset);
	
	D_FF RegWr (.q(RegWrOut), .d(RegWrIn), .reset, .clk);
	D_FF ALUSrc (.q(ALUSrcOut), .d(ALUSrcIn), .reset, .clk);
	D_FF MemWr (.q(MemWrOut), .d(MemWrIn), .reset, .clk);
	D_FF MemToReg (.q(MemToRegOut), .d(MemToRegIn), .reset, .clk);
	D_FF RegDest (.q(RegDestOut), .d(RegDestIn), .reset, .clk);

	TwoBitRegister ALUcntrl (.out(ALUcntrlOut), .in(ALUcntrlIn), .clk, .reset); 
	
endmodule
