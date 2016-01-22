/* NAME					|	thirtyTwoBitSlt.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  determines if a is less than b
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT [31:0]		|	Binary value if a is less than b (1 = true; 0 = false)
	A						|	INPUT  [31:0]		| 	input a
	B						|	INPUT  [31:0]		| 	input b
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Vivi Chuang
	ASSIGNMENT			| Lab 2: Register File
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module thirtyTwoBitSlt(OUT, A, B);

	// ports
	input [31:0] A, B;
	output [31:0] OUT;
	
	// wire
	wire [31:0] diff;
	wire overflow, noverflow, Cout, nCout, slt;
	
	thirtyTwoBitAdder difference (.SUM(diff), .Cout(Cout), .overflow(overflow), .A(A), .B(B), .op(1'b1));
	
	xor check (slt, diff[31], overflow);
	
	buf result0 (OUT[0],  slt);
	
	genvar i;
	generate
		for(i = 1; i < 32; i++) begin: setToZero
				buf results (OUT[i], 1'b0);
			end
	endgenerate

	
endmodule


// test
module thirtyTwoBitSlt_testbench();
	reg [31:0] A, B;

	wire [31:0] OUT;


	thirtyTwoBitSlt dut (.OUT, .A, .B);

	integer i;
	initial begin

			A = 2147483648; 
			B = 0; #10;
			
			A = 2147483648; 
			B = 1000000000; #10;

			
			
			A = 1; 
			B = 2147483648; #10;

			
			A = 50; 
			B = 60; #10;

			
			A = 2147483648; 
			B = 2147483648; #10;



			




	end
endmodule 