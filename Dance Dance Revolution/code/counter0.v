// the counter0 module counts from 0 to 9, carries, neg carries, and counts up 1/2 or down 1/2.
// PARAMETERS
// CLOCK             = cloCK
// RESET             = reset signal
// UP1               = single UP count
// UP2               = double UP count
// DOWN2             = double DOWN count
// DOWN1             = single down count
// DIG3              = third digit number to check if zero
// DIG2              = second digit number to check if zero
// DIG1              = first digit number to check if zero
// OUT               = current DIGIT number value (0 - 9)
// NEXT              = CARRY UP
// PREV              = CARRY DOWN
module counter0(CLOCK, RESET, UP1, UP2, DOWN2, DOWN1, DIG3, DIG2, DIG1, OUT, NEXT, PREV);

	// ports
	input CLOCK, RESET, UP1, UP2, DOWN2, DOWN1;
	input [3:0] DIG1, DIG2, DIG3;
	output [3:0] OUT;
	output reg NEXT, PREV;
	
	// stateholding variables
	wire [3:0] PS;
	reg [3:0] NS;
	reg [3:0] num;
	
	// assignments
	assign OUT = num;
	
	// variables
//	parameter [3:0] A = 4'b0000, B = 4'b0001, C = 4'b0010,
//						 D = 4'b0011, E = 4'b0100, F = 4'b0101,
//						 G = 4'b0110, H = 4'b0111, I = 4'b1000,
//						 J = 4'b1001, K = 4'b1010, L = 4'b1011,
//						 M = 4'b1100, N = 4'b1101;

	parameter [3:0] A = 0, B = 1, C = 2, D = 3, E = 4,
						 F = 5, G = 6, H = 7, I = 8, J = 9,
						 K = 10, L = 11, M = 12, N = 13;
						 
	// next state logic
	always @(PS)
		begin
			case(PS)
				A: begin
					if(UP2) NS = C;
					else if(UP1) NS = B;
					else if(DOWN2 && (DIG1 == 0) && (DIG2 == 0) && (DIG3 == 0)) NS = A;
					else if(DOWN2) NS = K;
					else if(DOWN1) NS = L;
					else NS = A;
					end
				B: begin
					if(UP2) NS = D;
					else if (UP1) NS = C;
					else if (DOWN2 && (DIG1 == 0) && (DIG2 == 0) && (DIG3 == 0)) NS = A;
					else if (DOWN2) NS = L;
					else if (DOWN1) NS = A;
					else NS = B;
					end
				C: begin
					if(UP2) NS = E;
					else if(UP1) NS = D;
					else if(DOWN2) NS = A;
					else if(DOWN1) NS = B;
					else NS = C;
					end
				D: begin
					if(UP2) NS = F;
					else if(UP1) NS = E;
					else if(DOWN2) NS = B;
					else if(DOWN1) NS = C;
					else NS = D;
					end
				E: begin
					if(UP2) NS = G;
					else if(UP1) NS = F;
					else if(DOWN2) NS = C;
					else if(DOWN1) NS = D;
					else NS = E;
					end
				F: begin
					if(UP2) NS = H;
					else if(UP1) NS = G;
					else if(DOWN2) NS = D;
					else if(DOWN1) NS = E;
					else NS = F;
					end
				G: begin
					if(UP2) NS = I;
					else if(UP1) NS = H;
					else if(DOWN2) NS = E;
					else if(DOWN1) NS = F;
					else NS = G;
					end
				H: begin
					if(UP2) NS = J;
					else if(UP1) NS = I;
					else if(DOWN2) NS = F;
					else if(DOWN1) NS = G;
					else NS = H;
					end
				I: begin
					if(UP2) NS = M;
					else if(UP1) NS = J;
					else if(DOWN2) NS = G;
					else if(DOWN1) NS = H;
					else NS = I;
					end
				J: begin
					if(UP2) NS = N;
					else if(UP1) NS = M;
					else if(DOWN2) NS = H;
					else if(DOWN1) NS = I;
					else NS = J;
					end
					
				K: NS = I;
				L: NS = J;
				M: NS = A;
				N: NS = B;
				
				default: NS = 4'bxxxx;
				endcase
		end
		
		// output logic
		always @(PS)
			begin
			case(PS)
				A: begin
					num = 0;
					NEXT = 0;
					end
				B: begin
					num = 1;
					NEXT = 0;
					end
				C: num = 2;
				D: num = 3;
				E: num = 4;
				F: num = 5;
				G: num = 6;
				H: num = 7;
				I: begin
					num = 8;
					PREV = 0;
					end
				J: begin
					num = 9;
					PREV = 0;
					end
				K: begin 
					num = 8;
					PREV = 1;
					end
				L: begin 
					num = 9;
					PREV = 1;
					end
				M: begin 
					num = 0;
					NEXT = 1;
					end
				N: begin 
					num = 1;
					NEXT = 1;
					end
				default: begin
					num = 3'bxxx;
					NEXT = 0;
					PREV = 0;
					end
				endcase
		end

		// state holding
		D_FF d0 (PS[0], NS[0], RESET, CLOCK);
		D_FF d1 (PS[1], NS[1], RESET, CLOCK);
		D_FF d2 (PS[2], NS[2], RESET, CLOCK);
		D_FF d3 (PS[3], NS[3], RESET, CLOCK);

endmodule

		
		
