module mux8to1(SELECT, D0, D1, D2, D3, D4, D5, D6, D7, Q);

	input [2:0] SELECT;
	input D0, D1, D2, D3, D4, D5, D6, D7;
	output reg Q;
	
	always @ (SELECT)
		begin
			case(SELECT)
				0: Q = D0;
				1:	Q = D1;
				2:	Q = D2;
				3:	Q = D3;
				4:	Q = D4;
				5:	Q = D5;
				6:	Q = D6;
				7:	Q = D7;
			endcase
		end
		
		
endmodule 