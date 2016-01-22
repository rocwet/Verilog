// 10 digit decimal counter
module counter0(CLOCK, RESET, UP1, UP2, DOWN, OUT, NEXT);

	input CLOCK, RESET, UP1, UP2, DOWN;
	output [3:0] OUT;
	output reg NEXT;
	
	wire [3:0] PS;
	reg [3:0] NS;
	
	reg [3:0] num;
	
	assign OUT = num;
	
	parameter [3:0] A = 4'b0000, B = 4'b0001, C = 4'b0010,
						 D = 4'b0011, E = 4'b0100, F = 4'b0101,
						 G = 4'b0110, H = 4'b0111, I = 4'b1000,
						 J = 4'b1001;
	
	always @(PS or UP or DOWN)
		begin
			case(PS):
				A: begin
					if(UP2) NS = C;
					else if(UP1) NS = B;
					end
				B: begin
					if(UP2) NS = D;
					else if(UP1) NS = C;
					end
				C: begin
					if(UP2) NS = E;
					else if(UP1) NS = D;
					end
				D: begin
					if(UP2) NS = F;
					else if(UP1) NS = E;
					end
				E: begin
					if(UP2) NS = G;
					else if(UP1) NS = F;
					end
				F: begin
					if(UP2) NS = H;
					else if(UP1) NS = G;
					end
				G: begin
					if(UP2) NS = I;
					else if(UP1) NS = H;
					end
				H: begin
					if(UP2) NS = J;
					else if(UP1) NS = I;
					end
				I: begin
					if(UP2) NS = A;
					else if(UP1) NS = J;
					end
				J: begin
					if(UP2) NS = B;
					else if(UP1) NS = A;
					end
				endcase
		end
		
		always @(PS)
			begin
			case(PS):
				A: begin
					num = 0;
					NEXT = 0;
					end
				B: num = 1;
				C: num = 2;
				D: num = 3;
				E: num = 4;
				F: num = 5;
				G: num = 6;
				H: num = 7;
				I: num = 8;
				J: begin
					num = 9;
					NEXT = 1;
					end
				endcase
		end


			D_FF d0 (PS[0], NS[0], RESET, CLOCK);
			D_FF d1 (PS[1], NS[1], RESET, CLOCK);
			D_FF d2 (PS[2], NS[2], RESET, CLOCK);
			D_FF d3 (PS[3], NS[3], RESET, CLOCK);

		
		
endmodule

		
		
