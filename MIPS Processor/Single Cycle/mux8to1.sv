/* NAME					|	mux8to1.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  Selects a bit of data from a 8 bit input
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT 				|	1 bit of data from selected 8 bit input
	IN						|	INPUT	 [7:0]		|	Data to be muxed
	SEL					|	INPUT  [2:0]		| 	The selected bit location from the 8 bit input
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module mux8to1(IN, OUT, SEL);  

	// ports
	input [7:0] IN;
	input [2:0] SEL;
	output OUT;
	
	// wires
	wire [1:0] muxOut;
	
	// 4:1 mux
	mux4to1 mux41_0 (.IN(IN[3:0]), .OUT(muxOut[0]), .SEL(SEL[1:0]));
	mux4to1 mux41_1 (.IN(IN[7:4]), .OUT(muxOut[1]), .SEL(SEL[1:0]));
	
	// 2:1 mux
	mux2to1 mux21_2 (.IN(muxOut), .OUT(OUT), .SEL(SEL[2]));

endmodule  
  
  
// test
module mux8to1_testbench();  
	reg [7:0] IN;
	reg [2:0] SEL;
	wire OUT;   
   
	mux8to1 dut (.IN, .OUT, .SEL);   
	integer i;
	initial begin
		for(i=0; i<256; i++) begin
			{IN, SEL} = i; #10;
		end
	end
  

endmodule 