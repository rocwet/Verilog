module LEDArray(CLOCK, RESET, COUNT, in, R0, R1, R2, R3, R4, R5, R6, R7,
					 CG0, CG1, CG2, CG3, CO0, CO1, CO2, CO3);

	input CLOCK, RESET;
	input [3:0] COUNT;
	
	output R0, R1, R2, R3, R4, R5, R6, R7;
	output CG0, CG1, CG2, CG3, CO0, CO1, CO2, CO3;
	
	input [35:0] in;
	
//	// column 0
//	mux8to1 muxO0 (COUNT, 0, 0, 0, 0, 0, 0, in[32], 0, CO0);
//	mux8to1 muxG0 (COUNT, in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7], CG0);
//	
//	// column 2
//	mux8to1 muxO1 (COUNT, 0, 0, 0, 0, 0, 0, in[33], 0, CO1);
//	mux8to1 muxG1 (COUNT, in[8], in[9], in[10], in[11], in[12], in[13], in[14], in[15], CG1);
//	
//	// column 4
//	mux8to1 muxO2 (COUNT, 0, 0, 0, 0, 0, 0, in[34], 0, CO2);
//	mux8to1 muxG2 (COUNT, in[16], in[17], in[18], in[19], in[20], in[21], in[22], in[23], CG2);
//	
//	
//	// column 6
//	mux8to1 muxO3 (COUNT, 0, 0, 0, 0, 0, 0, in[35], 0, CO3);
//	mux8to1 muxG3 (COUNT, in[24], in[25], in[26], in[27], in[28], in[29], in[30], in[31], CG3);

	assign R2 = ~5;
	assign CG0 = 5;
	
//	decode3to8 decodeRow (COUNT, R0, R1, R2, R3, R4, R5, R6, R7);

endmodule