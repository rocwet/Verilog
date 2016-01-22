/* NAME					|	mux2to1.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  Selects a bit of data from a 32 bit input
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT 				|	1 bit of data from selected 2 bit input
	IN						|	INPUT	 [1:0]		|	Data to be muxed
	SEL					|	INPUT  				| 	The selected bit location from the 2 bit input
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module mux2to1(IN, OUT, SEL);  

	// ports
	input [1:0] IN;
	input SEL;
	output OUT;
	
	// wires
	wire in1out, in2out;
	wire notSEL;
	
	// mux logic
	or (OUT, in1out, in2out);
	and (in1out, IN[1], SEL);
	and (in2out, IN[0], notSEL);
	not (notSEL, SEL);
	
endmodule  
  
  
// test
module mux2to1_testbench();  
	reg [1:0] IN;
	reg SEL;
	wire OUT;   
   
	mux2to1 dut (.IN, .OUT, .SEL);   
	integer i;
	initial begin
		for(i=0; i<8; i++) begin
			{IN, SEL} = i; #10;
		end
	end
  

endmodule 