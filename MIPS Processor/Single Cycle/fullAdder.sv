/* NAME					|	fullAdder.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  adds two values
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	SUM		         |	OUTPUT 				|	The sum of A and B
	Cout					|	OUTPUT				|	Carry out
	A						|	INPUT 				| 	input a
	B						|	INPUT 				| 	input b
	Cin					|	INPUT					|	Carry in
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Vivi Chuang
	ASSIGNMENT			| Lab 2: Register File
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module fullAdder(SUM, Cout, A, B, Cin);

	// ports
	input A, B, Cin;
	output Cout, SUM;
	
	// variables
	wire halfCarry, halfCarry2, halfSum;

	// two half adders
	halfAdder add1 (.SUM(halfSum), .CARRY(halfCarry) , .A(A)  , .B(B));
	halfAdder add2 (.SUM(SUM)    , .CARRY(halfCarry2), .A(Cin), .B(halfSum));
	
	or CARRYOUT (Cout, halfCarry, halfCarry2);
	
endmodule


// test
module fullAdder_testbench();
	reg A, B, Cin;
	wire SUM, Cout;

	fullAdder dut (.SUM, .Cout, .A, .B, .Cout);

	integer i;
	initial begin
		for(i=0; i<32; i++) begin
			{A, B, Cin} = i; #10;
		end
	end
endmodule 