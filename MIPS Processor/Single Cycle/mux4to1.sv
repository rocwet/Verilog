/* NAME					|	mux4to1.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  Selects a bit of data from a 4 bit input
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT 				|	1 bit of data from selected 4 bit input
	IN						|	INPUT	 [3:0]		|	Data to be muxed
	SEL					|	INPUT  [1:0]		| 	The selected bit location from the 4 bit input
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module mux4to1(IN, OUT, SEL);  
	input [3:0] IN;
	input [1:0] SEL;
	output OUT;
	
	wire [1:0] muxOut;
	
	mux2to1 mux21_0 (.IN(IN[1:0]), .OUT(muxOut[0]), .SEL(SEL[0]));
	mux2to1 mux21_1 (.IN(IN[3:2]), .OUT(muxOut[1]), .SEL(SEL[0]));
	
	mux2to1 mux21_2 (.IN(muxOut), .OUT(OUT), .SEL(SEL[1]));

	

	
endmodule  
  
module mux4to1_testbench();  
	reg [3:0] IN;
	reg [1:0] SEL;
	wire OUT;   
   
	mux4to1 dut (.IN, .OUT, .SEL);   
	integer i;
	initial begin
		for(i=0; i<64; i++) begin
			{IN, SEL} = i; #10;
		end
	end
  

endmodule 