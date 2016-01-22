// 10 digit decimal counter
module counter21(CLOCK, RESET, UP, DOWN, OUT, NEXT, PREV);

	input CLOCK, RESET, UP, DOWN;
	output [3:0] OUT;
	output reg NEXT, PREV;
	
	wire [3:0] PS;
	reg [3:0] NS;
	
	reg [3:0] num;
	
	assign OUT = num;
	
	parameter [3:0] A = 4'b0000, B = 4'b0001, C = 4'b0010,
						 D = 4'b0011, E = 4'b0100, F = 4'b0101,
						 G = 4'b0110, H = 4'b0111, I = 4'b1000,
						 J = 4'b1001, K = 4'b1010, L = 4'b1011;
	
	always @(CLOCK)
		begin
			case(PS)
				A: begin
					if(UP) NS = B;
					else if(DOWN) NS = L;
					else NS = A;
					end
				B: begin
					if(UP) NS = C;
					else if (DOWN) NS = A;
					else NS = B;
					end
				C: begin
					if(UP) NS = D;
					else if(DOWN) NS = B;
					else NS = C;
					end
				D: begin
					if(UP) NS = E;
					else if(DOWN) NS = C;
					else NS = D;
					end
				E: begin
					if(UP) NS = F;
					else if(DOWN) NS = D;
					else NS = E;
					end
				F: begin
					if(UP) NS = G;
					else if(DOWN) NS = E;
					else NS = F;
					end
				G: begin
					if(UP) NS = H;
					else if(DOWN) NS = F;
					else NS = G;
					end
				H: begin
					if(UP) NS = I;
					else if(DOWN) NS = G;
					else NS = H;
					end
				I: begin
					if(UP) NS = J;
					else if(DOWN) NS = H;
					else NS = I;
					end
				J: begin
					if(UP) NS = K;
					else if(DOWN) NS = I;
					else NS = J;
					end
				K: NS = A;
				L: NS = J;
				default: NS = 4'bxxxx;
				endcase
		end
		
		always @(CLOCK)
			begin
			case(PS)
				A: num = 0;
				B: num = 1;
				C: num = 2;
				D: num = 3;
				E: num = 4;
				F: num = 5;
				G: num = 6;
				H: num = 7;
				I: num = 8;
				J: num = 9;
				K: begin
					num = 0;
					NEXT = 1;
					end
				L: begin
					num = 9;
					PREV = 1;
					end
				default: begin
					num = 3'bxxx;
					NEXT = 0;
					PREV = 0;
					end

				endcase
		end


			D_FF d0 (PS[0], NS[0], RESET, CLOCK);
			D_FF d1 (PS[1], NS[1], RESET, CLOCK);
			D_FF d2 (PS[2], NS[2], RESET, CLOCK);
			D_FF d3 (PS[3], NS[3], RESET, CLOCK);

		
		
endmodule