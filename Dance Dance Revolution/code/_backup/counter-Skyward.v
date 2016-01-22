// 10 digit decimal counter
module counter(CLOCK, RESET, UP, DOWN, OUT);

	input CLOCK, RESET, UP, DOWN;
	output [3:0] OUT;
	
	wire [3:0] PS;
	reg [3:0] NS;
	
	reg [2:0] num;
	reg op;
	parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10;
	
	tenBitAdder(OUT, num, operation, overflow, carry, OUT);
	
	always @ (PS or UP or DOWN)
		case(PS)
			A: if(UP) NS = B;
				else if (DOWN) NS = C;
			B: NS = A;
			C: NS = A;
			
		endcase
		
	always @ (PS or UP or DOWN)
		case(PS)
			A: begin
				num = 0;
				op = 0;
				end
				
			B: begin
				num = 1;
				op = 0;
				end
				
			C: begin
				num = 1;
				op = 1;
				end
			
		endcase
	
//	parameter [3:0] A = 4'b0000, B = 4'b0001, C = 4'b0010,
//						 D = 4'b0011, E = 4'b0100, F = 4'b0101,
//						 G = 4'b0110, H = 4'b0111, I = 4'b1000,
//						 J = 4'b1001, K = 4'b1010, L = 4'b1011;
//	
//	always @(PS or UP or DOWN)
//		begin
//			NS[3] = (~PS[3]&PS[2]&PS[1]&PS[0]&UP) | (PS[3]&~PS[2]&~PS[1])&((PS[1]^UP) | (~PS[0]&~UP));
//			NS[2] = (~PS[3]&PS[2]&PS[1]&PS[0]&~UP) | (PS[3]&~PS[1]&~UP) | (PS[3]&~PS[0]&~UP) | (PS[3]&~PS[2]&~UP);
//			NS[1] = (~PS[2]&PS[1]&PS[0]&~UP) | (PS[2]&~PS[1]&~UP) | (PS[2]&~PS[0]&~UP);
//			NS[0] = (~PS[3]&~PS[2]&~PS[1]&PS[0]) | (~PS[3]&~PS[2]&PS[1]&~PS[0]) | (~PS[1]&PS[0]&~UP) | (PS[1]&~PS[0]&~UP);
//		end
//		
//		always @(PS)
//			begin
//				OUT = PS;
//				UPCARRY = PS[3]&~PS[2]&~PS[1]&PS[0];
//			end
//			
			D_FF d0 (PS[0], NS[0], RESET, CLOCK);
			D_FF d1 (PS[1], NS[1], RESET, CLOCK);
//			D_FF d2 (PS[2], NS[2], RESET, CLOCK);
//			D_FF d3 (PS[3], NS[3], RESET, CLOCK);

		
		
endmodule

		
		
