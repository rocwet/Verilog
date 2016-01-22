module row1Light (CLOCK, RESET, IN, LIGHTON);

	input CLOCK, RESET, IN;
	output LIGHTON;
	
	D_FF msb(LIGHTON, IN, RESET, CLOCK);
	
endmodule