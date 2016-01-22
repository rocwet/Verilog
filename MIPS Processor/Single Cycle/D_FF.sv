/* NAME					|	D_FF.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  D - Flip Flop logic
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	q			         |	OUTPUT 				|	next state
	d						|	INPUT	 				|	present state
	reset					|	INPUT  				| 	set back to 0
	clk					|	INPUT  				| 	the clock cycle
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module D_FF (q, d, reset, clk);

	// ports
	output reg q;
	input d, reset, clk;
	
	// logic
	always @(posedge clk)
		if (reset)
			q <= 0; // On reset, set to 0
		else
			q <= d; // Otherwise out = d
			
endmodule 

// test
module D_FF_testbench();  
	reg d;
	reg reset;
	reg clk;
	wire q;   
   
	D_FF dut (.q, .d, .reset, .clk);   
	
	integer i;
	initial begin

		
		for(i=0; i<256; i++) begin
			{d, reset, clk} = i; #10;
		end
		
	end
  

endmodule 