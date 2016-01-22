module DDR(CLOCK_50, SW9, SW, KEY0, KEY1, KEY2, KEY3, HEX0, HEX1, HEX2, HEX3, GPIO_0, LED, LEDG);

	input CLOCK_50, SW9, KEY0, KEY1, KEY2, KEY3;
	input [8:0] SW;
	output [1:7] HEX0, HEX1, HEX2, HEX3;
	output [35:0] GPIO_0;
	output [7:0] LED;
	output [7:0] LEDG;
	
	// wires
	wire reset, left, up, down, right;
	wire [3:0] C;
	wire [2:0] dig0, dig1, dig2, dig3;
	wire carry0, carry1, carry2, carry3;
	wire neg0, neg1, neg2, neg3;
	
	wire [35:0] in;
	wire [9:0] random;
	wire [2:0] randomer;
	
	wire [31:0] clk;
	parameter whichClock = 24;
	
	// assignments
	assign reset = SW9;

	assign LEDG[3] = left;
	assign LEDG[2] = up;
	assign LEDG[1] = down;
	assign LEDG[0] = right;
	
	// divide clock
	clock_divider div (CLOCK_50,clk);
	
	// define input rules
	inputRules inLeft  (clk[whichClock], reset, ~KEY3, left);
	inputRules inUp    (clk[whichClock], reset, ~KEY2, up);
	inputRules inDown  (clk[whichClock], reset, ~KEY1, down);
	inputRules inRight (clk[whichClock], reset, ~KEY0, right);
	
	// generate random values for random dance steps
	nineBitLFSR rand (clk[whichClock], reset, random);
	threeBitLFSR rander (clk[whichClock], reset, randomer);
	
	normalLight(clk[whichClock], reset, random[randomer], in[0]);
	normalLight(clk[whichClock], reset, in[0], in[1]);
	normalLight(clk[whichClock], reset, in[1], in[2]);
	normalLight(clk[whichClock], reset, in[2], in[3]);
	normalLight(clk[whichClock], reset, in[3], in[4]);
	normalLight(clk[whichClock], reset, in[4], in[5]);
	normalLight(clk[whichClock], reset, in[5], in[32]);
	normalLight(clk[whichClock], reset, in[32], in[7]);
	
	normalLight(clk[whichClock], reset, random[8], in[8]);
	normalLight(clk[whichClock], reset, in[8], in[9]);
	normalLight(clk[whichClock], reset, in[9], in[10]);
	normalLight(clk[whichClock], reset, in[10], in[11]);
	normalLight(clk[whichClock], reset, in[11], in[12]);
	normalLight(clk[whichClock], reset, in[12], in[13]);
	normalLight(clk[whichClock], reset, in[13], in[33]);
	normalLight(clk[whichClock], reset, in[33], in[15]);
	
	normalLight(clk[whichClock], reset, random[6], in[16]);
	normalLight(clk[whichClock], reset, in[16], in[17]);
	normalLight(clk[whichClock], reset, in[17], in[18]);
	normalLight(clk[whichClock], reset, in[18], in[19]);
	normalLight(clk[whichClock], reset, in[19], in[20]);
	normalLight(clk[whichClock], reset, in[20], in[21]);
	normalLight(clk[whichClock], reset, in[21], in[34]);
	normalLight(clk[whichClock], reset, in[34], in[23]);
	
	normalLight(clk[whichClock], reset, random[5], in[24]);
	normalLight(clk[whichClock], reset, in[24], in[25]);
	normalLight(clk[whichClock], reset, in[25], in[26]);
	normalLight(clk[whichClock], reset, in[26], in[27]);
	normalLight(clk[whichClock], reset, in[27], in[28]);
	normalLight(clk[whichClock], reset, in[28], in[29]);
	normalLight(clk[whichClock], reset, in[29], in[35]);
	normalLight(clk[whichClock], reset, in[35], in[31]);
	
	

	
	
	counter2 count0 (clk[whichClock], reset, SW[0], dig0, carry0);
	counter2 count1 (clk[whichClock], reset, carry0 , dig1, carry1);
	counter2 count2 (clk[whichClock], reset, carry1 , dig2, carry2);
	counter2 count3 (clk[whichClock], reset, carry2 , dig3, carry3);

//	counter count0 (clk[whichClock], reset, SW[0], SW[1], dig0);
//	counter count1 (clk[whichClock], reset, carry0 , neg0, dig1, carry1, neg1);
//	counter count2 (clk[whichClock], reset, carry1 , neg1, dig2, carry2, neg2);
//	counter count3 (clk[whichClock], reset, carry2 , neg2, dig3, carry3, neg3);
	
	threeBitCounter threeCounter (clk[whichClock], reset, C);
	LEDArray leda (clk[whichClock], reset, C, in,
						GPIO_0[22], GPIO_0[19], GPIO_0[16], GPIO_0[13], GPIO_0[3], GPIO_0[6], 
						GPIO_0[9] , GPIO_0[12], GPIO_0[24], GPIO_0[18], GPIO_0[1], GPIO_0[7],
						GPIO_0[23], GPIO_0[17], GPIO_0[2] , GPIO_0[8]);


	
	
	
	scoreDisplay digit0 (dig0, HEX0);
	scoreDisplay digit1 (dig1, HEX1);
	scoreDisplay digit2 (dig2, HEX2);
	scoreDisplay digit3 (dig3, HEX3);
	
	
endmodule
	