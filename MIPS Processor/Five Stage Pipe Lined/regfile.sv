/* NAME					|	regfile.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  The regfile is a 32 by 32 registry file, with write and read capabilities
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	ReadData1         |	OUTPUT [31:0]		|	Reads data 1 from the 1st selected
	ReadData2			|	OUTPUT [31:0]		|	Reads data 2 from the 2nd selected
	WriteData			|	INPUT  [31:0]		| 	The data to be written
	ReadRegister1		|	INPUT  [4:0]		|  5 bit value that selects a register to read
	ReadRegister2		|	INPUT  [4:0]		|  5 bit value that selects a register to read
	WriteRegister		|	INPUT  [4:0]		|  5 bit value that selects a register to write
	RegWrite				|	INPUT  				|  Determines whether data can be written
	clk					|	INPUT					|  Clock Cycle
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module regfile(ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, RegWrite, clk);
	
	// ports
	output [31:0] ReadData1, ReadData2;
	input  [31:0] WriteData;
	input  [4:0]  ReadRegister1, ReadRegister2;
	input  [4:0]  WriteRegister;
	input         RegWrite;
	input         clk;
	
	// wires
	wire	 [31:0] decodeOut;
	wire   [31:0] regOut [31:0];
	
	// decoder logic
	decode5to32 dec5to32(.IN(WriteRegister), .OUT(decodeOut), .ENABLE(RegWrite));
	
	// reg0 is always 0
	register32to32 reg0  (.IN(32'b0), .OUT(regOut[0]),  .ENABLE(1),  .CLK(clk));
	
	// register logic IGNORE reg0
	register32to32 reg1  (.IN(WriteData), .OUT(regOut[1]),  .ENABLE(decodeOut[1]),  .CLK(clk));
	register32to32 reg2  (.IN(WriteData), .OUT(regOut[2]),  .ENABLE(decodeOut[2]),  .CLK(clk));
	register32to32 reg3  (.IN(WriteData), .OUT(regOut[3]),  .ENABLE(decodeOut[3]),  .CLK(clk));
	register32to32 reg4  (.IN(WriteData), .OUT(regOut[4]),  .ENABLE(decodeOut[4]),  .CLK(clk));
	register32to32 reg5  (.IN(WriteData), .OUT(regOut[5]),  .ENABLE(decodeOut[5]),  .CLK(clk));
	register32to32 reg6  (.IN(WriteData), .OUT(regOut[6]),  .ENABLE(decodeOut[6]),  .CLK(clk));
	register32to32 reg7  (.IN(WriteData), .OUT(regOut[7]),  .ENABLE(decodeOut[7]),  .CLK(clk));
	register32to32 reg8  (.IN(WriteData), .OUT(regOut[8]),  .ENABLE(decodeOut[8]),  .CLK(clk));
	register32to32 reg9  (.IN(WriteData), .OUT(regOut[9]),  .ENABLE(decodeOut[9]),  .CLK(clk));
	register32to32 reg10 (.IN(WriteData), .OUT(regOut[10]), .ENABLE(decodeOut[10]), .CLK(clk));
	register32to32 reg11 (.IN(WriteData), .OUT(regOut[11]), .ENABLE(decodeOut[11]), .CLK(clk));
	register32to32 reg12 (.IN(WriteData), .OUT(regOut[12]), .ENABLE(decodeOut[12]), .CLK(clk));
	register32to32 reg13 (.IN(WriteData), .OUT(regOut[13]), .ENABLE(decodeOut[13]), .CLK(clk));
	register32to32 reg14 (.IN(WriteData), .OUT(regOut[14]), .ENABLE(decodeOut[14]), .CLK(clk));
	register32to32 reg15 (.IN(WriteData), .OUT(regOut[15]), .ENABLE(decodeOut[15]), .CLK(clk));
	register32to32 reg16 (.IN(WriteData), .OUT(regOut[16]), .ENABLE(decodeOut[16]), .CLK(clk));
	register32to32 reg17 (.IN(WriteData), .OUT(regOut[17]), .ENABLE(decodeOut[17]), .CLK(clk));
	register32to32 reg18 (.IN(WriteData), .OUT(regOut[18]), .ENABLE(decodeOut[18]), .CLK(clk));
	register32to32 reg19 (.IN(WriteData), .OUT(regOut[19]), .ENABLE(decodeOut[19]), .CLK(clk));
	register32to32 reg20 (.IN(WriteData), .OUT(regOut[20]), .ENABLE(decodeOut[20]), .CLK(clk));
	register32to32 reg21 (.IN(WriteData), .OUT(regOut[21]), .ENABLE(decodeOut[21]), .CLK(clk));
	register32to32 reg22 (.IN(WriteData), .OUT(regOut[22]), .ENABLE(decodeOut[22]), .CLK(clk));
	register32to32 reg23 (.IN(WriteData), .OUT(regOut[23]), .ENABLE(decodeOut[23]), .CLK(clk));
	register32to32 reg24 (.IN(WriteData), .OUT(regOut[24]), .ENABLE(decodeOut[24]), .CLK(clk));
	register32to32 reg25 (.IN(WriteData), .OUT(regOut[25]), .ENABLE(decodeOut[25]), .CLK(clk));
	register32to32 reg26 (.IN(WriteData), .OUT(regOut[26]), .ENABLE(decodeOut[26]), .CLK(clk));
	register32to32 reg27 (.IN(WriteData), .OUT(regOut[27]), .ENABLE(decodeOut[27]), .CLK(clk));
	register32to32 reg28 (.IN(WriteData), .OUT(regOut[28]), .ENABLE(decodeOut[28]), .CLK(clk));
	register32to32 reg29 (.IN(WriteData), .OUT(regOut[29]), .ENABLE(decodeOut[29]), .CLK(clk));
	register32to32 reg30 (.IN(WriteData), .OUT(regOut[30]), .ENABLE(decodeOut[30]), .CLK(clk));
	register32to32 reg31 (.IN(WriteData), .OUT(regOut[31]), .ENABLE(decodeOut[31]), .CLK(clk));

	// mux logic
	mux32by32to32 mux0 (.IN(regOut[31:0]), .OUT(ReadData1), .SEL(ReadRegister1));
	mux32by32to32 mux1 (.IN(regOut[31:0]), .OUT(ReadData2), .SEL(ReadRegister2));
	
endmodule


