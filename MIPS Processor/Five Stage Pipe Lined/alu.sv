/* NAME					|	alu.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  determines if a is less than b
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	Output		      |	OUTPUT [31:0]		|	Binary value if a is less than b 	(1 = true; 0 = false)
	CarryOut				|	OUTPUT				|	Carry out
	zero					|	OUTPUT				|	Binary value if Output is 0 			(1 = true; 0 = false)
	overflow				|	OUTPUT				|	checks if the output is overflown 	(1 = true; 0 = false)
	negative 			|	OUTPUT				|	checks if the output is negative 	(1 = true; 0 = false)
	BussA					|	INPUT  [31:0]		| 	input a
	BussB					|	INPUT  [31:0]		| 	input b
	ALUControl			|	INPUT  [1:0]		| 	determines type of operation:
																00 = ADD
																01 = XOR
																10 = SUB
																11 = SLT
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Vivi Chuang
	ASSIGNMENT			| Lab 2: Register File
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module alu (Output, zero, BussA, BussB, ALUControl);

	//ports
	input [31:0] BussA, BussB;
	input [1:0] ALUControl;
	output [31:0] Output;
	output zero;
	
	//variables
	wire op; 
	wire [31:0] adds, xors, subs, slts; 
	wire nor0, nor1, nor2, nor3, nor4, nor5, nor6, nor7, and0, and1, and2;
	
	
	//choosing operation: add/subtract
	thirtyTwoBitAdder adder (.SUM(adds), .Cout(), .overflow(), .A(BussA), .B(BussB), .op(ALUControl[1]));
	
	//xor
	thirtyTwoBitXor xorer   (.outXOR(xors), .a(BussA), .b(BussB)); 	

	//SLT
	thirtyTwoBitSlt slter   (.OUT(slts), .A(BussA), .B(BussB)); 

	//choose function
	
	genvar i;
	generate
		for(i = 0; i < 32; i++) begin: eachBit
			mux4to1 m0 (.IN({slts[i], adds[i], xors[i], adds[i]}), .OUT(Output[i]), .SEL(ALUControl));		
		end
	endgenerate
		
	//zero flag
	nor n0 (nor0, Output[0],  Output[1],  Output[2],  Output[3]);
	nor n1 (nor1, Output[4],  Output[5],  Output[6],  Output[7]);
	nor n2 (nor2, Output[8],  Output[9],  Output[10], Output[11]);
	nor n3 (nor3, Output[12], Output[13], Output[14], Output[15]);
	nor n4 (nor4, Output[16], Output[17], Output[18], Output[19]);
	nor n5 (nor5, Output[20], Output[21], Output[22], Output[23]);
	nor n6 (nor6, Output[24], Output[25], Output[26], Output[27]);
	nor n7 (nor7, Output[28], Output[29], Output[30], Output[31]);
	
	and a0 (and0, nor0, nor1, nor2, nor3);
	and a1 (and1, nor4, nor5, nor6, nor7);
	and a2 (and2, and0, and1);
	
	buf dut0 (zero, and2);

endmodule 
