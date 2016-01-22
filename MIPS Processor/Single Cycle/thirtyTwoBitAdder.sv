/* NAME					|	thirtyTwoBitAdder.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  adds two 32 bit values
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	SUM		         |	OUTPUT [31:0]		|	The sum of A and B
	Cout					|	OUTPUT				|	Carry out
	overflow				|	OUTPUT				|	checks if the addition is overflown
	A						|	INPUT  [31:0]		| 	input a
	B						|	INPUT  [31:0]		| 	input b
	op						|	INPUT  				| 	type of operation, 0 = add; 1 = subtract
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Vivi Chuang
	ASSIGNMENT			| Lab 2: Register File
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module thirtyTwoBitAdder(SUM, Cout, overflow, A, B, op);

	// ports
	input [31:0] A, B;
	input op;
	output [31:0] SUM;
	output overflow;
	output Cout;
	
	// variable
	wire [30:0] midCarry;
	wire [31:0] Bn, notB;
	
	//invert B
	genvar h;
	generate
		for(h = 0; h < 32; h++) begin: bnot
			not nB (notB[h], B[h]);
		end
	endgenerate

	
	//choosing the operation: subtract/add
	genvar i;
	generate
		for(i = 0; i < 32; i++) begin: bselection
			mux2to1 m0 (.IN({notB[i], B[i]}), .OUT(Bn[i]), .SEL(op));
		end
	endgenerate

	
	//adding bits
	fullAdder add0  (.SUM(SUM[0]), .Cout(midCarry[0]), .A(A[0]), .B(Bn[0]), .Cin(op)); 
	
	genvar j;
	generate
		for(j = 1; j < 31; j++) begin: addBits
			fullAdder add1to30  (.SUM(SUM[j]), .Cout(midCarry[j]), .A(A[j]), .B(Bn[j]), .Cin(midCarry[j-1]));  
		end
	endgenerate
	
	fullAdder add31 (.SUM(SUM[31]), .Cout(Cout), .A(A[31]), .B(Bn[31]), .Cin(midCarry[30]));  

	//check overflow
	xor overflo (overflow, Cout, midCarry[30]);

endmodule
	



// testbench
module thirtyTwoBitAdder_testbench();
	reg [31:0] A, B;
	reg op;
	wire Cout, overflow;
	wire [31:0] SUM;

	thirtyTwoBitAdder dut (.SUM, .Cout, .overflow, .A, .B, .op);

	integer i;
	initial begin

			A = 2147483648; 
			B = 0; 
			op = 0; #10;
			
			A = 2147483648; 
			B = 0; 
			op = 1; #10;
			
			
			A = 2147483648; 
			B = 1; 
			op = 0; #10;
			
			A = 2147483648; 
			B = 1; 
			op = 1; #10;
			
			A = 2147483648; 
			B = 2147483648; 
			op = 0; #10;

			A = 2147483648; 
			B = 2147483648; 
			op = 1; #10;
			
			A = 1; 
			B = 1; 
			op = 0; #10;
			
			A = 1; 
			B = 1; 
			op = 1; #10;


	end
endmodule 