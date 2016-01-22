module decode3to8(IN, OUT0, OUT1, OUT2, OUT3, OUT4, OUT5, OUT6, OUT7);
	
	input [3:0] IN;
	output reg OUT0, OUT1, OUT2, OUT3, OUT4, OUT5, OUT6, OUT7;
	
	
	always @ (IN)
		begin
			case (IN)
					0: begin
						OUT0 = 0;
						OUT1 = 1;
						OUT2 = 1;
						OUT3 = 1;
						OUT4 = 1;
						OUT5 = 1;
						OUT6 = 1;
						OUT7 = 1;
						end
					1: begin
						OUT0 = 1;
						OUT1 = 0;
						OUT2 = 1;
						OUT3 = 1;
						OUT4 = 1;
						OUT5 = 1;
						OUT6 = 1;
						OUT7 = 1;
						end
					2: begin
						OUT0 = 1;
						OUT1 = 1;
						OUT2 = 0;
						OUT3 = 1;
						OUT4 = 1;
						OUT5 = 1;
						OUT6 = 1;
						OUT7 = 1;
						end
					3: begin
						OUT0 = 1;
						OUT1 = 1;
						OUT2 = 1;
						OUT3 = 0;
						OUT4 = 1;
						OUT5 = 1;
						OUT6 = 1;
						OUT7 = 1;
						end
					4: begin
						OUT0 = 1;
						OUT1 = 1;
						OUT2 = 1;
						OUT3 = 1;
						OUT4 = 0;
						OUT5 = 1;
						OUT6 = 1;
						OUT7 = 1;
						end
					5: begin
						OUT0 = 1;
						OUT1 = 1;
						OUT2 = 1;
						OUT3 = 1;
						OUT4 = 1;
						OUT5 = 0;
						OUT6 = 1;
						OUT7 = 1;
						end
					6: begin
						OUT0 = 1;
						OUT1 = 1;
						OUT2 = 1;
						OUT3 = 1;
						OUT4 = 1;
						OUT5 = 1;
						OUT6 = 0;
						OUT7 = 1;	
						end
					7: begin
						OUT0 = 1;
						OUT1 = 1;
						OUT2 = 1;
						OUT3 = 1;
						OUT4 = 1;
						OUT5 = 1;
						OUT6 = 1;
						OUT7 = 0;
						end
				endcase
		end

endmodule