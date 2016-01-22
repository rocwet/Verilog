/* NAME					|	mux32by32to32.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  A multi dimensional mux that chooses a register file
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE						|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	OUT		         |	OUTPUT [31:0]			|	Outputs the selected 32-bit register
	IN						|	INPUT  [31:0][31:0]	|	32 x 32-bit register array
	SEL					|	INPUT  [4:0]			|  5 bit value that selects the 32-bit register from 32
	#################################################################################################
	AUTHOR            | Minhhue H Khuu
	ASSIGNMENT			| Lab 1: Register File
	CLASS					| EE 471
	DATE					| 01/16/2015
	#################################################################################################
*/ 
module mux32by32to32(IN, OUT, SEL);  

	// ports
	input [31:0] IN [31:0];
	input [4:0] SEL;
	output [31:0] OUT;
	
	// mux logic
	mux32to1 mux32_0  (.IN(IN[SEL]), .OUT(OUT[0]),  .SEL(5'b00000));
	mux32to1 mux32_1  (.IN(IN[SEL]), .OUT(OUT[1]),  .SEL(5'b00001));
	mux32to1 mux32_2  (.IN(IN[SEL]), .OUT(OUT[2]),  .SEL(5'b00010));
	mux32to1 mux32_3  (.IN(IN[SEL]), .OUT(OUT[3]),  .SEL(5'b00011));
	mux32to1 mux32_4  (.IN(IN[SEL]), .OUT(OUT[4]),  .SEL(5'b00100));
	mux32to1 mux32_5  (.IN(IN[SEL]), .OUT(OUT[5]),  .SEL(5'b00101));
	mux32to1 mux32_6  (.IN(IN[SEL]), .OUT(OUT[6]),  .SEL(5'b00110));
	mux32to1 mux32_7  (.IN(IN[SEL]), .OUT(OUT[7]),  .SEL(5'b00111));
	mux32to1 mux32_8  (.IN(IN[SEL]), .OUT(OUT[8]),  .SEL(5'b01000));
	mux32to1 mux32_9  (.IN(IN[SEL]), .OUT(OUT[9]),  .SEL(5'b01001));
	mux32to1 mux32_10 (.IN(IN[SEL]), .OUT(OUT[10]), .SEL(5'b01010));
	mux32to1 mux32_11 (.IN(IN[SEL]), .OUT(OUT[11]), .SEL(5'b01011));
	mux32to1 mux32_12 (.IN(IN[SEL]), .OUT(OUT[12]), .SEL(5'b01100));
	mux32to1 mux32_13 (.IN(IN[SEL]), .OUT(OUT[13]), .SEL(5'b01101));
	mux32to1 mux32_14 (.IN(IN[SEL]), .OUT(OUT[14]), .SEL(5'b01110));
	mux32to1 mux32_15 (.IN(IN[SEL]), .OUT(OUT[15]), .SEL(5'b01111));
	mux32to1 mux32_16 (.IN(IN[SEL]), .OUT(OUT[16]), .SEL(5'b10000));
	mux32to1 mux32_17 (.IN(IN[SEL]), .OUT(OUT[17]), .SEL(5'b10001));
	mux32to1 mux32_18 (.IN(IN[SEL]), .OUT(OUT[18]), .SEL(5'b10010));
	mux32to1 mux32_19 (.IN(IN[SEL]), .OUT(OUT[19]), .SEL(5'b10011));
	mux32to1 mux32_20 (.IN(IN[SEL]), .OUT(OUT[20]), .SEL(5'b10100));
	mux32to1 mux32_21 (.IN(IN[SEL]), .OUT(OUT[21]), .SEL(5'b10101));
	mux32to1 mux32_22 (.IN(IN[SEL]), .OUT(OUT[22]), .SEL(5'b10110));
	mux32to1 mux32_23 (.IN(IN[SEL]), .OUT(OUT[23]), .SEL(5'b10111));
	mux32to1 mux32_24 (.IN(IN[SEL]), .OUT(OUT[24]), .SEL(5'b11000));
	mux32to1 mux32_25 (.IN(IN[SEL]), .OUT(OUT[25]), .SEL(5'b11001));
	mux32to1 mux32_26 (.IN(IN[SEL]), .OUT(OUT[26]), .SEL(5'b11010));
	mux32to1 mux32_27 (.IN(IN[SEL]), .OUT(OUT[27]), .SEL(5'b11011));
	mux32to1 mux32_28 (.IN(IN[SEL]), .OUT(OUT[28]), .SEL(5'b11100));
	mux32to1 mux32_29 (.IN(IN[SEL]), .OUT(OUT[29]), .SEL(5'b11101));
	mux32to1 mux32_30 (.IN(IN[SEL]), .OUT(OUT[30]), .SEL(5'b11110));
	mux32to1 mux32_31 (.IN(IN[SEL]), .OUT(OUT[31]), .SEL(5'b11111));
endmodule  
  
  
// test  
module mux32by32to32_testbench();  
	reg [31:0] IN [31:0];
	reg [4:0] SEL;
	wire [31:0] OUT;   
   
	mux32by32to32 dut (.IN, .OUT, .SEL);   
	
	integer i;
	initial begin
		IN[0]  = 32'b00000000000000000000000000000000;
		IN[1]  = 32'b00000000000000000000000000000000;
		IN[2]  = 32'b00000000000000000000000000000000;
		IN[3]  = 32'b11111111111111111111111111111111;
		IN[4]  = 32'b00000000000000000000000000000000;
		IN[5]  = 32'b00000000000000000000000000000000;
		IN[6]  = 32'b00000000000000000000000000000000;
		IN[7]  = 32'b00000000000000000000000000000000;
		IN[8]  = 32'b00000000000000000000000000000000;
		IN[9]  = 32'b00000000000000000000000000000000;
		IN[10] = 32'b00000000000000000000000000000000;
		IN[11] = 32'b00000000000000000000000000000000;
		IN[12] = 32'b00000000000000000000000000000000;
		IN[13] = 32'b00000000000000000000000000000000;
		IN[14] = 32'b00000000000000000000000000000000;
		IN[15] = 32'b00000000000000000000000000000000;
		IN[16] = 32'b00000000000000000000010000000001;
		IN[17] = 32'b00000000000000000000000000000000;
		IN[18] = 32'b00000000000000000000000000000000;
		IN[19] = 32'b00000000000000000000000000000000;
		IN[20] = 32'b00000000000000000000000000000000;
		IN[21] = 32'b00000000000000000000000000000000;
		IN[22] = 32'b00000000000000000000000000000000;
		IN[23] = 32'b00000000000000000000000000000000;
		IN[24] = 32'b00000000000000000000000000000000;
		IN[25] = 32'b00000000000000000000000000000000;
		IN[26] = 32'b00000000000000000000000000000000;
		IN[27] = 32'b00000000000000000000000000000000;
		IN[28] = 32'b00000000000000000000000000000000;
		IN[29] = 32'b00000000000000000000000000000000;
		IN[30] = 32'b00000000000000000000000000000000;
		IN[31] = 32'b00000000000000000000000000000000;

		
		for(i=0; i<31; i++) begin
			{SEL} = i; #10;
		end
		
	end
  

endmodule 