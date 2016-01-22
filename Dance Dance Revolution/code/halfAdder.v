// The halfAdder module adds two bits, and provides the sum and carry.
// PARAMTER
// A          = first bit to be added
// B          = second bit to be added
// carry      = carry of the sum
// sum        = sum of A and B
module halfAdder(A, B, carry, sum);

	// ports
	input A, B;
	output sum, carry;
	
	// assignments
	assign carry = A&B;
	assign sum = A ^ B;
	
endmodule