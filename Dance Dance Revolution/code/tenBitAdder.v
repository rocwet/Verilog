// The tenBitAdder module will add two 10 bit binary numbers
// This module is a top level module of multiple fullAdder modules
// PARAMTER
// A       = first 10 bit binary number
// B       = second 10 bit binary number
// carry   = carry of the sum 
// sum     = sum of A and B
module tenBitAdder(A, B, op, overflow, carry, sum);

	// ports
	input [9:0] A, B;
	input op;
	output [9:0] sum;
	output overflow;
	output carry;
	
	// variable
	wire [8:0] midCarry;
	
	
	// cascaded fullAdders
	fullAdder add0 (A[0], B[0] ^ op, op, midCarry[0], sum[0]);
	fullAdder add1 (A[1], B[1] ^ op, midCarry[0], midCarry[1], sum[1]);
	fullAdder add2 (A[2], B[2] ^ op, midCarry[1], midCarry[2], sum[2]);
	fullAdder add3 (A[3], B[3] ^ op, midCarry[2], midCarry[3], sum[3]);
	fullAdder add4 (A[4], B[4] ^ op, midCarry[3], midCarry[4], sum[4]);
	fullAdder add5 (A[5], B[5] ^ op, midCarry[4], midCarry[5], sum[5]);
	fullAdder add6 (A[6], B[6] ^ op, midCarry[5], midCarry[6], sum[6]);
	fullAdder add7 (A[7], B[7] ^ op, midCarry[6], midCarry[7], sum[7]);
	fullAdder add8 (A[8], B[8] ^ op, midCarry[7], midCarry[8], sum[8]);
	fullAdder add9 (A[9], B[9] ^ op, midCarry[8], carry, sum[9]);
	
	assign overflow = carry ^ midCarry[8];
	
	
endmodule

	