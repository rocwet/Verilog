module stopLed (CLOCK, RESET, PASS, GOTCHA, HOLDIT);

	input CLOCK, GOTCHA, HOLDIT, RESET;
	output reg PASS;
	
	wire [1:0]PS;
	reg [1:0] NS;
	
	parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	
	always @ (PS or GOTCHA)
		case(PS)
			A: if (GOTCHA) NS = C;
				else if(HOLDIT) NS = B;
				else NS = A;
			B: if (GOTCHA) NS = C;
				else if(HOLDIT) NS = B;
				else NS = A;
			C: if (GOTCHA) NS = C;
				else if(HOLDIT) NS = B;
				else NS = B;
			default: NS = 2'bxx;
		endcase
		
	always @ (PS or GOTCHA)
		case(PS)
			A: PASS = 0;
			B: PASS = 1;
			C: PASS = 1;
			default: PASS = 1'bx;
		endcase
	
	D_FF msb(PS[0], NS[0], RESET, CLOCK);
	D_FF msb2(PS[1], NS[1], RESET, CLOCK);
	
endmodule