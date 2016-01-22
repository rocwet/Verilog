/* NAME					|	mux32to1.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  Selects a bit of data from a 32 bit input
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT 				|	1 bit of data from selected 32 bit input
	IN						|	INPUT	 [31:0]		|	Data to be muxed
	SEL					|	INPUT  [4:0]		| 	The selected bit location from the 32 bit input
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module mux32to1(IN, OUT, SEL);  

	// ports
	input [31:0] IN;
	input [4:0] SEL;
	output OUT;
	
	// wires
	wire [3:0] muxOut;
	
	// 8:1 mux
	mux8to1 mux81_0 (.IN(IN[7:0]), 	.OUT(muxOut[0]), .SEL(SEL[2:0]));
	mux8to1 mux81_1 (.IN(IN[15:8]), 	.OUT(muxOut[1]), .SEL(SEL[2:0]));
	mux8to1 mux81_2 (.IN(IN[23:16]),	.OUT(muxOut[2]), .SEL(SEL[2:0]));
	mux8to1 mux81_3 (.IN(IN[31:24]), .OUT(muxOut[3]), .SEL(SEL[2:0]));
	
	// 4:1 mux
	mux4to1 mux41_0 (.IN(muxOut), .OUT(OUT), .SEL(SEL[4:3]));

endmodule  
  
 
// test 
module mux32to1_testbench();  
	reg [31:0] IN;
	reg [4:0] SEL;
	wire OUT;   
   
	mux32to1 dut (.IN, .OUT, .SEL);   
	integer i;
	initial begin
		for(i=0; i<1024; i++) begin
			{IN, SEL} = i; #10;
		end
	end
  

endmodule 