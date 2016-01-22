/* NAME					|	signExtend.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  extends signs a 16 bit number to 32 bit => Two's Compliment
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	out					|	OUTPUT [31:0]		|	sign extended number
	in						| 	IN	[15:0]			| 	the number that will be sign extended
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 3: MIPS Single-Cycle CPU
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module signExtend (out, in);

	// ports
	input [15:0] in;
	output [31:0] out;
	
	// copy first 16 bits
	genvar h;
	generate
		for(h = 0; h < 16; h++) begin: copyBits
			buf firstBits (out[h], in[h]);
		end
	endgenerate
	
	// extended the last 16 bits
	genvar i;
	generate
		for (i = 16; i < 32; i++) begin: extendBits
			buf lastBits (out[i], in[15]);
		end
	endgenerate
	
endmodule

module signExtend_testbench();
	reg [15:0] in;
	wire [31:0] out;
	
	signExtend dut (.out, .in);
	
	initial begin
	
		in = 16'b0000000000000000; #10;
		in = 16'b1000000000000000; #10;
		in = 16'b1010101010101010;	#10;
		in = 16'b0101010101010101;	#10;
		
	end
	
endmodule
	