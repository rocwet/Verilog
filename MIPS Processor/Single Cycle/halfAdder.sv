/* NAME					|	halfAdder.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  adds two values
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	SUM		         |	OUTPUT 				|	The sum of A and B
	CARRY					|	OUTPUT				|	Carry of A and B
	A						|	INPUT 				| 	input a
	B						|	INPUT 				| 	input b
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Vivi Chuang
	ASSIGNMENT			| Lab 2: Register File
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module halfAdder(SUM, CARRY, A, B);

	// ports
	input A, B;
	output SUM, CARRY;

	// assignments
	and CARRYS (CARRY, A, B);
	xor SUMS	  (SUM, A, B);
	
endmodule


// test
module halfAdder_testbench();
	reg A, B;
	wire SUM, CARRY;

	halfAdder dut (.SUM, .CARRY, .A, .B);

	integer i;
	initial begin
		for(i=0; i<8; i++) begin
			{A, B} = i; #10;
		end
	end
endmodule 