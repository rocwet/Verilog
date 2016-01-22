/* NAME					|	meM_wR.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  pipelined stage 4
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	DwIn 					|  IN [31:0]			|  DwIn
	AwIn					|  IN [4:0]          |  AwIn 
	clk					|  IN					   |  clk 
	reset					|  IN					   |  reset signal
	RegWrIn				|  IN						|  RegWrIn
	DwOut					|  OUT [31:0]        |  DwOut 
	AwOut					|  OUT [4:0]         |  AwOut 
	RegWrOut				|  OUT  		         |  RegWrOut
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 4: MIPS Pipelined CPU
	CLASS					| EE 471
	DATE					| 03/13/2015
	#################################################################################################
*/
module meM_wR(DwOut, AwOut, DwIn, AwIn, clk, reset, RegWrOut, RegWrIn);

	output [31:0] DwOut;
	output [4:0] AwOut;
	output RegWrOut; 
	input [31:0] DwIn;
	input [4:0] AwIn;
	input clk, reset, RegWrIn;
	
	thirtyTwoBitRegister dw32(.out(DwOut), .in(DwIn), .clk, .reset);

	fiveBitRegister aw5(.out(AwOut), .in(AwIn), .clk, .reset);
	
	D_FF RegWr (.q(RegWrOut), .d(RegWrIn), .reset, .clk);
	
endmodule
