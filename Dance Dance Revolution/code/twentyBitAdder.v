// The tenBitAdder module will add two 10 bit binary numbers
// This module is a top level module of multiple fullAdder modules
// PARAMTER
// A       = first 10 bit binary number
// B       = second 10 bit binary number
// carry   = carry of the sum 
// sum     = sum of A and B
module twentyBitAdder(A, B, carry, sum);

	// ports
	input [9:0] A, B;
	output [9:0] sum;
	output carry;
	
	// variable
	wire [8:0] midCarry;
	
	// cascaded fullAdders
	fullAdder add0 (A[0], B[0], 0, midCarry[0], sum[0]);
	fullAdder add1 (A[1], B[1], midCarry[0], midCarry[1], sum[1]);
	fullAdder add2 (A[2], B[2], midCarry[1], midCarry[2], sum[2]);
	fullAdder add3 (A[3], B[3], midCarry[2], midCarry[3], sum[3]);
	fullAdder add4 (A[4], B[4], midCarry[3], midCarry[4], sum[4]);
	fullAdder add5 (A[5], B[5], midCarry[4], midCarry[5], sum[5]);
	fullAdder add6 (A[6], B[6], midCarry[5], midCarry[6], sum[6]);
	fullAdder add7 (A[7], B[7], midCarry[6], midCarry[7], sum[7]);
	fullAdder add8 (A[8], B[8], midCarry[7], midCarry[8], sum[8]);
	fullAdder add9 (A[9], B[9], midCarry[8], midCarry[9], sum[9]);
	fullAdder add10 (A[10], B[10], midCarry[9], midCarry[10], sum[10]);
	fullAdder add11 (A[11], B[11], midCarry[10], midCarry[11], sum[11]);
	fullAdder add12 (A[12], B[12], midCarry[11], midCarry[12], sum[12]);
	fullAdder add13 (A[13], B[13], midCarry[12], midCarry[13], sum[13]);
	fullAdder add14 (A[14], B[14], midCarry[13], midCarry[14], sum[14]);
	fullAdder add15 (A[15], B[15], midCarry[14], midCarry[15], sum[15]);
	fullAdder add16 (A[16], B[16], midCarry[15], midCarry[16], sum[16]);
	fullAdder add17 (A[17], B[17], midCarry[16], midCarry[17], sum[17]);
	fullAdder add18 (A[18], B[18], midCarry[17], midCarry[18], sum[18]);
	fullAdder add19 (A[19], B[19], midCarry[18], carry, sum[19]);
	
endmodule
