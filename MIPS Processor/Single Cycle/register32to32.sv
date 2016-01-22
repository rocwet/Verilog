/* NAME					|	register32to32.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  Stores 32 bit of information, can keep or write new data in
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT [31:0]		|	Output data presented
	IN						|	OUTPUT [31:0]		|	Input data to be written in
	ENABLE				|	INPUT 				| 	Determines if new data should be written
	CLK					|	INPUT					|  Clock Cycle
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module register32to32(IN, OUT, ENABLE, CLK);  

	// ports
	input [31:0] IN ;
	input ENABLE;
	input CLK;
	output [31:0] OUT;
	
	// wires
	wire [31:0] COPY;
	
	// mux logic
	mux2to1 copy0  ( .IN({IN[0],  OUT[0]}),  .OUT(COPY[0]),  .SEL(ENABLE));
	mux2to1 copy1  ( .IN({IN[1],  OUT[1]}),  .OUT(COPY[1]),  .SEL(ENABLE));
	mux2to1 copy2  ( .IN({IN[2],  OUT[2]}),  .OUT(COPY[2]),  .SEL(ENABLE));
	mux2to1 copy3  ( .IN({IN[3],  OUT[3]}),  .OUT(COPY[3]),  .SEL(ENABLE));
	mux2to1 copy4  ( .IN({IN[4],  OUT[4]}),  .OUT(COPY[4]),  .SEL(ENABLE));
	mux2to1 copy5  ( .IN({IN[5],  OUT[5]}),  .OUT(COPY[5]),  .SEL(ENABLE));
	mux2to1 copy6  ( .IN({IN[6],  OUT[6]}),  .OUT(COPY[6]),  .SEL(ENABLE));
	mux2to1 copy7  ( .IN({IN[7],  OUT[7]}),  .OUT(COPY[7]),  .SEL(ENABLE));
	mux2to1 copy8  ( .IN({IN[8],  OUT[8]}),  .OUT(COPY[8]),  .SEL(ENABLE));
	mux2to1 copy9  ( .IN({IN[9],  OUT[9]}),  .OUT(COPY[9]),  .SEL(ENABLE));
	mux2to1 copy10 ( .IN({IN[10], OUT[10]}), .OUT(COPY[10]), .SEL(ENABLE));
	mux2to1 copy11 ( .IN({IN[11], OUT[11]}), .OUT(COPY[11]), .SEL(ENABLE));
	mux2to1 copy12 ( .IN({IN[12], OUT[12]}), .OUT(COPY[12]), .SEL(ENABLE));
	mux2to1 copy13 ( .IN({IN[13], OUT[13]}), .OUT(COPY[13]), .SEL(ENABLE));
	mux2to1 copy14 ( .IN({IN[14], OUT[14]}), .OUT(COPY[14]), .SEL(ENABLE));
	mux2to1 copy15 ( .IN({IN[15], OUT[15]}), .OUT(COPY[15]), .SEL(ENABLE));
	mux2to1 copy16 ( .IN({IN[16], OUT[16]}), .OUT(COPY[16]), .SEL(ENABLE));
	mux2to1 copy17 ( .IN({IN[17], OUT[17]}), .OUT(COPY[17]), .SEL(ENABLE));
	mux2to1 copy18 ( .IN({IN[18], OUT[18]}), .OUT(COPY[18]), .SEL(ENABLE));
	mux2to1 copy19 ( .IN({IN[19], OUT[19]}), .OUT(COPY[19]), .SEL(ENABLE));
	mux2to1 copy20 ( .IN({IN[20], OUT[20]}), .OUT(COPY[20]), .SEL(ENABLE));
	mux2to1 copy21 ( .IN({IN[21], OUT[21]}), .OUT(COPY[21]), .SEL(ENABLE));
	mux2to1 copy22 ( .IN({IN[22], OUT[22]}), .OUT(COPY[22]), .SEL(ENABLE));
	mux2to1 copy23 ( .IN({IN[23], OUT[23]}), .OUT(COPY[23]), .SEL(ENABLE));
	mux2to1 copy24 ( .IN({IN[24], OUT[24]}), .OUT(COPY[24]), .SEL(ENABLE));
	mux2to1 copy25 ( .IN({IN[25], OUT[25]}), .OUT(COPY[25]), .SEL(ENABLE));
	mux2to1 copy26 ( .IN({IN[26], OUT[26]}), .OUT(COPY[26]), .SEL(ENABLE));
	mux2to1 copy27 ( .IN({IN[27], OUT[27]}), .OUT(COPY[27]), .SEL(ENABLE));
	mux2to1 copy28 ( .IN({IN[28], OUT[28]}), .OUT(COPY[28]), .SEL(ENABLE));
	mux2to1 copy29 ( .IN({IN[29], OUT[29]}), .OUT(COPY[29]), .SEL(ENABLE));
	mux2to1 copy30 ( .IN({IN[30], OUT[30]}), .OUT(COPY[30]), .SEL(ENABLE));
	mux2to1 copy31 ( .IN({IN[31], OUT[31]}), .OUT(COPY[31]), .SEL(ENABLE));

	// d flip flop logic
	// reset is always false since register has no way of resetting
	D_FF d0 (  .q(OUT[0]),  .d(COPY[0]),  .reset(false), .clk(CLK));
	D_FF d1 (  .q(OUT[1]),  .d(COPY[1]),  .reset(false), .clk(CLK));
	D_FF d2 (  .q(OUT[2]),  .d(COPY[2]),  .reset(false), .clk(CLK));
	D_FF d3 (  .q(OUT[3]),  .d(COPY[3]),  .reset(false), .clk(CLK));
	D_FF d4 (  .q(OUT[4]),  .d(COPY[4]),  .reset(false), .clk(CLK));
	D_FF d5 (  .q(OUT[5]),  .d(COPY[5]),  .reset(false), .clk(CLK));
	D_FF d6 (  .q(OUT[6]),  .d(COPY[6]),  .reset(false), .clk(CLK));
	D_FF d7 (  .q(OUT[7]),  .d(COPY[7]),  .reset(false), .clk(CLK));
	D_FF d8 (  .q(OUT[8]),  .d(COPY[8]),  .reset(false), .clk(CLK));
	D_FF d9 (  .q(OUT[9]),  .d(COPY[9]),  .reset(false), .clk(CLK));
	D_FF d10 ( .q(OUT[10]), .d(COPY[10]), .reset(false), .clk(CLK));
	D_FF d11 ( .q(OUT[11]), .d(COPY[11]), .reset(false), .clk(CLK));
	D_FF d12 ( .q(OUT[12]), .d(COPY[12]), .reset(false), .clk(CLK));
	D_FF d13 ( .q(OUT[13]), .d(COPY[13]), .reset(false), .clk(CLK));
	D_FF d14 ( .q(OUT[14]), .d(COPY[14]), .reset(false), .clk(CLK));
	D_FF d15 ( .q(OUT[15]), .d(COPY[15]), .reset(false), .clk(CLK));
	D_FF d16 ( .q(OUT[16]), .d(COPY[16]), .reset(false), .clk(CLK));
	D_FF d17 ( .q(OUT[17]), .d(COPY[17]), .reset(false), .clk(CLK));
	D_FF d18 ( .q(OUT[18]), .d(COPY[18]), .reset(false), .clk(CLK));
	D_FF d19 ( .q(OUT[19]), .d(COPY[19]), .reset(false), .clk(CLK));
	D_FF d20 ( .q(OUT[20]), .d(COPY[20]), .reset(false), .clk(CLK));
	D_FF d21 ( .q(OUT[21]), .d(COPY[21]), .reset(false), .clk(CLK));
	D_FF d22 ( .q(OUT[22]), .d(COPY[22]), .reset(false), .clk(CLK));
	D_FF d23 ( .q(OUT[23]), .d(COPY[23]), .reset(false), .clk(CLK));
	D_FF d24 ( .q(OUT[24]), .d(COPY[24]), .reset(false), .clk(CLK));
	D_FF d25 ( .q(OUT[25]), .d(COPY[25]), .reset(false), .clk(CLK));
	D_FF d26 ( .q(OUT[26]), .d(COPY[26]), .reset(false), .clk(CLK));
	D_FF d27 ( .q(OUT[27]), .d(COPY[27]), .reset(false), .clk(CLK));
	D_FF d28 ( .q(OUT[28]), .d(COPY[28]), .reset(false), .clk(CLK));
	D_FF d29 ( .q(OUT[29]), .d(COPY[29]), .reset(false), .clk(CLK));
	D_FF d30 ( .q(OUT[30]), .d(COPY[30]), .reset(false), .clk(CLK));
	D_FF d31 ( .q(OUT[31]), .d(COPY[31]), .reset(false), .clk(CLK));

endmodule  


// test
module register32to32_testbench();  
	reg [31:0] IN;
	reg ENABLE;
	reg CLK;
	wire [31:0] OUT;   
   
	register32to32 dut (.IN, .OUT, .ENABLE, .CLK);   
	
	integer i;
	initial begin
		for(i=0; i<256; i++) begin
			{IN,ENABLE,CLK} = i; #10;
		end
	end
  
endmodule 