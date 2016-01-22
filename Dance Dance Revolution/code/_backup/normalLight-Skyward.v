module normalLight (CLOCK, RESET, OLD, NEW);

	input CLOCK, RESET;
	input OLD;
	output reg NEW;
	
	wire PS;
	reg NS;
	
	parameter A = 0, B = 1;
	
	always @ (PS)
		case(PS)
			A: NS = B;
			B: NS = A;
		endcase
		
	always @ (PS)
		case (PS)
			B: NEW = OLD;
		endcase
		
	D_FF stage0 (PS, NS, RESET, CLOCK);
	
endmodule