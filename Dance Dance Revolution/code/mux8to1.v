// the mux8to1 is a 8:1 mux for the column of the LED array
// PARAMETERS
// SELECT     = 3 bit selection input
// D          = 8 bit input
// Q          = output
module mux8to1(SELECT, D, Q);
	
	// ports
	input [2:0] SELECT;
	input [7:0] D;
	output Q;
	
	// variable
	wire [7:0] w;
	
	// assignments
	assign w[7] = SELECT[2] & SELECT[1] & SELECT[0] & D[7];
	assign w[6] = SELECT[2] & SELECT[1] & ~SELECT[0] & D[6];
	assign w[5] = SELECT[2] & ~SELECT[1] & SELECT[0] & D[5];
	assign w[4] = SELECT[2] & ~SELECT[1] & ~SELECT[0] & D[4];
	assign w[3] = ~SELECT[2] & SELECT[1] & SELECT[0] & D[3];
	assign w[2] = ~SELECT[2] & SELECT[1] & ~SELECT[0] & D[2];
	assign w[1] = ~SELECT[2] & ~SELECT[1] & SELECT[0] & D[1];
	assign w[0] = ~SELECT[2] & ~SELECT[1] & ~SELECT[0] & D[0];
	
	// final assignment
	assign Q = w[7] | w[6] | w[5] | w[4] | w[3] | w[2] | w[1] | w[0]; 
		
		
endmodule 