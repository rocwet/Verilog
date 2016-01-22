module redLED (CLOCK, RESET, LED);

	input CLOCK, RESET;
	output reg [7:0] LED;
	
	wire [5:0] PS;
	reg [5:0] NS;
	
	parameter [5:0] A = 0, B = 1, C = 2, D = 3, E = 4,
						 F = 5, G = 6, H = 7, I = 8, J = 9,
						 K = 10, L = 11, M = 12, N = 13, O = 14,
						 P = 15, Q = 16, R = 17, S = 18, T = 19,
						 V = 20, W = 21, X = 22, Y = 23, Z = 24,
						 AA = 25, AB = 26, AC = 27, AD = 28, AE = 29,
						 AF = 30, AG = 31, AH = 32, AI = 33, AJ = 34,
						 AK = 35;
	
	always @ (PS)
		case (PS)
			A: NS = B;
			B: NS = C;
			C: NS = D;
			D: NS = E;
			E: NS = F;
			F: NS = G;
			G: NS = H;
			H: NS = I;
			I: NS = J;
			J: NS = K;
			K: NS = L;
			L: NS = M;
			M: NS = N;
			N: NS = O;
			O: NS = P;
			P: NS = Q;
			Q: NS = R;
			R: NS = S;
			S: NS = T;
			T: NS = V;
			V: NS = W;
			W: NS = X;
			X: NS = Y;
			Y: NS = Z;
			Z: NS = AA;
			AA: NS = AB;
			AB: NS = AC;
			AC: NS = AD;
			AD: NS = AE;
			AE: NS = AF;
			AF: NS = AG;
			AG: NS = AH;
			AH: NS = AI;
			AI: NS = AJ;
			AJ: NS = AK;
			AK: NS = A;

			default: NS = 6'bxxxxx;
		endcase
		
	always @  (PS)
		case (PS)
			A: LED = 8'b00000001;
			B: LED = 8'b00000011;
			C: LED = 8'b00000111;
			D: LED = 8'b00001111;
			E: LED = 8'b00011111;
			F: LED = 8'b00111111;
			G: LED = 8'b01111111;
			H: LED = 8'b11111111;
			I: LED = 8'b01111111;
			J: LED = 8'b00111111;
			K: LED = 8'b00011111;
			L: LED = 8'b00001111;
			M: LED = 8'b00000111;
			N: LED = 8'b00000011;
			O: LED = 8'b00000001;
			P: LED = 8'b00000000;
			Q: LED = 8'b11111111;
			R: LED = 8'b00000000;
			S: LED = 8'b11111111;
			T: LED = 8'b00000000;
			V: LED = 8'b10000000;
			W: LED = 8'b11000000;
			X: LED = 8'b11100000;
			Y: LED = 8'b11110000;
			Z: LED = 8'b11111000;
			AA: LED = 8'b11111100;
			AB: LED = 8'b11111110;
			AC: LED = 8'b11111111;
			AD: LED = 8'b01111111;
			AE: LED = 8'b00111111;
			AF: LED = 8'b00011111;
			AG: LED = 8'b00001111;
			AH: LED = 8'b00000111;
			AI: LED = 8'b00000011;
			AJ: LED = 8'b00000001;
			AK: LED = 8'b00000000;
			default: LED = 8'bxxxxxxxx;
		endcase
	
	D_FF stage0 (PS[0], NS[0], RESET, CLOCK);
	D_FF stage1 (PS[1], NS[1], RESET, CLOCK);
	D_FF stage2 (PS[2], NS[2], RESET, CLOCK);
	D_FF stage3 (PS[3], NS[3], RESET, CLOCK);
	D_FF stage4 (PS[4], NS[4], RESET, CLOCK);	
	D_FF stage5 (PS[5], NS[5], RESET, CLOCK);	
	
endmodule
		