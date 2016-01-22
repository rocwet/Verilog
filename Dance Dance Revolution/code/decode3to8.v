// the decode3to8 module is a 3:8 decoder for the rows for the LED array
// PARAMETERS
// IN     = 3 bit input
// OUT0   = output 0
// OUT1   = output 1
// OUT2   = output 2
// OUT3   = output 3
// OUT4   = output 4
// OUT5   = output 5
// OUT6   = output 6
// OUT7   = output 7
module decode3to8(IN, OUT0, OUT1, OUT2, OUT3, OUT4, OUT5, OUT6, OUT7);
	
	// ports
	input [2:0] IN;
	output OUT0, OUT1, OUT2, OUT3, OUT4, OUT5, OUT6, OUT7;
	
	// assignments
	assign OUT0 = ~(~IN[2] & ~IN[1] & ~IN[0]);
	assign OUT1 = ~(~IN[2] & ~IN[1] & IN[0]);
	assign OUT2 = ~(~IN[2] & IN[1] & ~IN[0]);
	assign OUT3 = ~(~IN[2] & IN[1] & IN[0]);
	assign OUT4 = ~(IN[2] & ~IN[1] & ~IN[0]);
	assign OUT5 = ~(IN[2] & ~IN[1] & IN[0]);
	assign OUT6 = ~(IN[2] & IN[1] & ~IN[0]);
	assign OUT7 = ~(IN[2] & IN[1] & IN[0]);
	
endmodule