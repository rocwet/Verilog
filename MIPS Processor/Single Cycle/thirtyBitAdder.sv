/* NAME					|	thirtyBitAdder.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  adds two 32 bit values
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	SUM		         |	OUTPUT [29:0]		|	The sum of A and B
	A						|	INPUT  [29:0]		| 	input a
	B						|	INPUT  [29:0]		| 	input b
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Vivi Chuang
	ASSIGNMENT			| Lab 2: Register File
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module thirtyBitAdder(SUM, A, B);

	// ports
	input [29:0] A, B;
	output [29:0] SUM;
	
	// variable
	wire [28:0] midCarry;
		
	//adding bits
	fullAdder add0  (.SUM(SUM[0]), .Cout(midCarry[0]), .A(A[0]), .B(B[0]), .Cin(1'b1)); 
	
	genvar j;
	generate
		for(j = 1; j < 29; j++) begin: addBits
			fullAdder add1to30  (.SUM(SUM[j]), .Cout(midCarry[j]), .A(A[j]), .B(B[j]), .Cin(midCarry[j-1]));  
		end
	endgenerate
	
	fullAdder add29 (.SUM(SUM[29]), .Cout(Cout), .A(A[29]), .B(B[29]), .Cin(midCarry[28]));  

endmodule
	
// testbench
module thirtyBitAdder_testbench();
	reg [29:0] A, B;
	wire [29:0] SUM;
	thirtyBitAdder dut (.SUM, .A, .B);


	initial begin

#10			A = 1234; 
			B = 0; 

#10			A = 648; 
			B = 0;
			
			
#10			A = 83648; 
			B = 1; 

			
#10			A = 83658; 
			B = 1; 


#10			A = 214748; 
			B = 248; 

#10			A = 1; 
			B = 1; 

#10			A = 1; 
			B = 2; 
	end
endmodule 