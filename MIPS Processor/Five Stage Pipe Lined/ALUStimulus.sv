// Test bench for ALU file
`timescale 1 ps / 100 fs

module ALUStimulus();

	parameter ClockDelay = 100000;

	reg [31:0] BussA, BussB;
	reg [1:0] ALUControl;

	wire [31:0] Output;
	wire zero, overflow, CarryOut, negative;

	integer i;

	// If your register file module is not named "alu" then you will
	// have to change the following line in order to create an instance of
	// your register file.  Also you must make sure that the port declarations
	// match up with the module instance in this stimulus file.
	alu alu1(.Output, .zero, .BussA, .BussB, .ALUControl);

	initial begin

		/* Addition unit testing */
		ALUControl=00; 
		BussA=32'h00000DEF; BussB=32'h00000ABC; #(ClockDelay); // Should output 000018AB
		BussA=32'h00001234; BussB=32'h00000105; #(ClockDelay); // Should output 00001339
		BussA=32'h7FFFFFFF; BussB=32'h00000001; #(ClockDelay); // Should output 80000000, overflow, negative
		
		/* Subtraction unit testing */
		ALUControl=10; 
		BussA=32'h00000DEF; BussB=32'h00000ABC; #(ClockDelay); // Should output 00000333	
		BussA=32'h00001234; BussB=32'h00000105; #(ClockDelay); // Should output 0000112F
		BussA=32'h80000000; BussB=32'h00000001; #(ClockDelay); // Should output 7FFFFFFF, overflow

		/* You should test your units EXTENSIVELY here.  We just gave a few ideas
         above to get you started.  Make sure you've checked all outputs for all
         "interesting" cases. */
			
		/* xor unit testing */
		ALUControl=01; 
		BussA=32'b00000000000000000000000000000000; BussB=32'b00000000000000000000000000000000; #(ClockDelay); // Should output 32'b0
		BussA=32'b00000000000000000011111110100000; BussB=32'b00000111000000000001011010000000; #(ClockDelay); // Should output 00000111000000000010100100100000
		BussA=32'b00000000000000000000000000000000; BussB=32'b00000000000000000000000000000000; #(ClockDelay); // Should output 
		BussA=32'b00000000000000000000001000000001; BussB=32'b00000000000000000000000000000000; #(ClockDelay); // Should output 
		BussA=32'b10000000000000000000000000000000; BussB=32'b10000000000000000000000000000000; #(ClockDelay); // Should output 
		BussA=32'b10000000000000000000000000000000; BussB=32'b00000000000000000000000000000000; #(ClockDelay); // Should output 
		
		/* slt unit testing */
		ALUControl=11; 
		BussA=32'b00000000000000000000000000000000; BussB=32'b00000000000000000000000000000000; #(ClockDelay); // Should output 0
		BussA=32'b00000000000000000011111110100000; BussB=32'b00000111000000000001011010000000; #(ClockDelay); // Should output 1
		BussA=32'b00000000000000000000000000000000; BussB=32'b00100000000000000000000000000000; #(ClockDelay); // Should output 1
		BussA=32'b00000000000000000000001000000001; BussB=32'b00000000000000000000000000000000; #(ClockDelay); // Should output 0
		BussA=32'b10000000000000000000000000000000; BussB=32'b10000000000000000000000000000000; #(ClockDelay); // Should output 0
		BussA=32'b10000000000000000000000000000000; BussB=32'b00000000000000000000000000000000; #(ClockDelay); // Should output 1


	end
endmodule

