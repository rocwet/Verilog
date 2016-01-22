// The fullAdder module adds two bits and has carry in and carry out
// fullAdder uses two half adder to create a full adder
// PARAMETER
// A         = first bit to be added
// B         = second bit to be added
// Cin       = carry in
// Cout      = carry out
// sum       = sum of A and B
module fullAdder(A, B, Cin, Cout, sum);

	// ports
	input A, B, Cin;
	output Cout, sum;
	
	// variables
	wire halfCarry, halfCarry2, halfSum;

	// two half adders
	halfAdder add1 (A, B, halfCarry, halfSum);
	halfAdder add2 (Cin, halfSum, halfCarry2, sum);
	assign Cout = halfCarry | halfCarry2;
	
endmodule
	