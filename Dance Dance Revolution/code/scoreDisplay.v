// The winner module will determine who the winner is of the Tug Of War game
// PARAMETER
// CLOCK         = clock cycle
// RESET         = reset signal
// W             = win count
// HEX           = hex3 7 segment display
module scoreDisplay(W, HEX);
	
	// ports
	input [3:0] W;
	output [1:7] HEX;
	
	// variables
	reg [1:7] h;
	
	parameter [3:0] A = 4'b0000, B = 4'b0001, C = 4'b0010,
						 D = 4'b0011, E = 4'b0100, F = 4'b0101,
						 G = 4'b0110, H = 4'b0111, I = 4'b1000,
						 J = 4'b1001;
	
	// assignments 
	assign HEX = h;
	
	// output logic
	always @(W)
		case(W)
			A: h = ~7'b1111110;
			B: h = ~7'b0110000;
			C: h = ~7'b1101101;
			D: h = ~7'b1111001;
			E: h = ~7'b0110011;
			F: h = ~7'b1011011;
			G: h = ~7'b1011111;
			H: h = ~7'b1110000;
			I: h = ~7'b1111111;
			J: h = ~7'b1111011;
		endcase
			
	
endmodule