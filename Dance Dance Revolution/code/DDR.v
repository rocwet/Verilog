// DDR is the top level module that plays Dance Dance Revolution
// PARAMETERS
// CLOCK_50       = 50 MHz Clock
// SW9            = reset switch
// SW             = switch for debugging
// KEY0           = left button
// KEY1           = up button
// KEY2           = down button
// KEY3           = right button
// HEX0           = hex0 display for score: digit 0
// HEX1           = hex1 display for score: digit 1
// HEX2           = hex2 display for score: digit 2
// HEX3           = hex3 display for score: digit 3
// GPIO_0         = 8 x 8 LED ARRAY
// LED            = red led for debugging
// LEDG           = green led for debugging
module DDR(CLOCK_50, SW9, SW, KEY0, KEY1, KEY2, KEY3, HEX0, HEX1, HEX2, HEX3, GPIO_0, LED, LEDG, LLED);

	// ports
	input CLOCK_50, SW9, KEY0, KEY1, KEY2, KEY3;
	input [8:0] SW;
	output [1:7] HEX0, HEX1, HEX2, HEX3;
	output [35:0] GPIO_0;
	output [7:0] LED;
	output [0:7] LEDG;
	output [1:0] LLED;
	
	// wires
	wire reset, left, up, down, right;
	wire [3:0] dig0, dig1, dig2, dig3;
	wire [7:0] row;
	
	// green columns
	wire [0:7] col0G;
	wire [0:7] col1G;
	wire [0:7] col2G;
	wire [0:7] col3G;
	
	// orange columns
	wire [0:7] col0O;
	wire [0:7] col1O;
	wire [0:7] col2O;
	wire [0:7] col3O;

	// carry for counter
	wire carryUp0, carryUp1, carryUp2;
	wire carryDown0, carryDown1, carryDown2;
	wire upTwo, upOne, downTwo;
	wire uptwo0, upone0, downtwo0, uptwo1, upone1, downtwo1;
	wire a0, a1, a2, a3;

	
	// RESET 
	assign reset = SW9;
	reg val;
	// DIVIDED CLOCK
	wire [31:0] clk;
	
	always @ (SW)
		case(SW)
			0: val = 0;
			1: val = 1;
			2: val = 2;
			4: val = 3;
		endcase
		
	parameter whichClock = 4;
	clock_divider div (CLOCK_50,clk);
	
	// INPUT RULES
	inputRules inLeft  (clk[whichClock], reset, ~KEY3, left);
	inputRules inUp    (clk[whichClock], reset, ~KEY2, up);
	inputRules inDown  (clk[whichClock], reset, ~KEY1, down);
	inputRules inRight (clk[whichClock], reset, ~KEY0, right);
	
	// generate random values for random dance steps
	nineBitLFSR rand (clk[whichClock], reset, random);
	wire [9:0] random;
	
	
	// 1 Hz signal
	twentyBitCounter f0 (clk[whichClock], reset, 0, val, num);
	twentyBitCounter f1 (clk[whichClock], reset, 1, val, num1);
	twentyBitCounter f2 (clk[whichClock], reset, 2, val, num2);
	twentyBitCounter f3 (clk[whichClock], reset, 3, val, num3);
	wire num, num1, num2, num3;
	
	// COUNTER FOR DECODER AND MUX
	threeBitCounter count (clk[whichClock], reset, C);
	wire [2:0] C;

	// MUX GREEN COLUMNS
	mux8to1 CG0(C, col0G, GPIO_0[24]);
	mux8to1 CG1(C, col1G, GPIO_0[18]);
	mux8to1 CG2(C, col2G, GPIO_0[1]);
	mux8to1 CG3(C, col3G, GPIO_0[7]);
	
	// MUX ORANGE COLUMNS
	mux8to1 CO0(C, col0O, GPIO_0[23]);
	mux8to1 CO1(C, col1O, GPIO_0[17]);
	mux8to1 CO2(C, col2O, GPIO_0[2]);
	mux8to1 CO3(C, col3O, GPIO_0[8]);
	
	// DECODE ROW
	decode3to8 decodeRow (C, GPIO_0[22], GPIO_0[19], GPIO_0[16], GPIO_0[13], GPIO_0[3],GPIO_0[6], GPIO_0[9], GPIO_0[12]);
				  
	// COLUMN 0
	rowRegularLight c0r0 (num, reset, random[0], col0G[0]);
	rowRegularLight c0r1 (num, reset, col0G[0], col0G[1]);
	rowRegularLight c0r2 (num, reset, col0G[1], col0G[2]);
	rowRegularLight c0r3 (num, reset, col0G[2], col0G[3]);
	rowRegularLight c0r4 (num, reset, col0G[3], col0G[4]);
	rowRegularLight c0r5 (num, reset, col0G[4], col0G[5]);
	targetLight c0r6 (num, reset, uptwo0, col0G[5], col0O[6]);
	targetLight c0r7 (num, reset, upone0, col0O[6], col0G[7]);
	
	rowRegularLight s0 (num, reset, col0G[7], a0);
	missLight miss0 (clk[whichClock], reset, num, a0, downtwo01);
	
	scoreTracker col0 (clk[whichClock], reset, left, col0G[7], col0O[6], uptwo0, downtwo0, upone0);
	
	// COLUMN 1
	rowRegularLight c1r0 (num, reset, random[5], col1G[0]);
	rowRegularLight c1r1 (num, reset, col1G[0], col1G[1]);
	rowRegularLight c1r2 (num, reset, col1G[1], col1G[2]);
	rowRegularLight c1r3 (num, reset, col1G[2], col1G[3]);
	rowRegularLight c1r4 (num, reset, col1G[3], col1G[4]);
	rowRegularLight c1r5 (num, reset, col1G[4], col1G[5]);
	targetLight c1r6 (num, reset, uptwo1, col1G[5], col1O[6]);
	targetLight c1r7 (num, reset, upone1, col1O[6], col1G[7]);
	
	rowRegularLight s1 (num, reset, col1G[7], a1);
	missLight miss1 (clk[whichClock], reset, num1, a1, downtwo11);
	
	scoreTracker col1 (clk[whichClock], reset, up, col1G[7], col1O[6], uptwo1, downtwo1, upone1);
	
	// COLUMN 2
	rowRegularLight c2r0 (num, reset, random[7], col2G[0]);
	rowRegularLight c2r1 (num, reset, col2G[0], col2G[1]);
	rowRegularLight c2r2 (num, reset, col2G[1], col2G[2]);
	rowRegularLight c2r3 (num, reset, col2G[2], col2G[3]);
	rowRegularLight c2r4 (num, reset, col2G[3], col2G[4]);
	rowRegularLight c2r5 (num, reset, col2G[4], col2G[5]);
	targetLight c2r6 (num, reset, uptwo2, col2G[5], col2O[6]);
	targetLight c2r7 (num, reset, upone2, col2O[6], col2G[7]);
	
	rowRegularLight s2 (num, reset, col2G[7], a2);
	missLight miss2 (clk[whichClock], reset, num2, a2, downtwo21);
	
	scoreTracker col2 (clk[whichClock], reset, down, col2G[7], col2O[6], uptwo2, downtwo2, upone2);
	
	// COLUMN 3
	rowRegularLight c3r0 (num, reset, random[3], col3G[0]);
	rowRegularLight c3r1 (num, reset, col3G[0], col3G[1]);
	rowRegularLight c3r2 (num, reset, col3G[1], col3G[2]);
	rowRegularLight c3r3 (num, reset, col3G[2], col3G[3]);
	rowRegularLight c3r4 (num, reset, col3G[3], col3G[4]);
	rowRegularLight c3r5 (num, reset, col3G[4], col3G[5]);
	targetLight c3r6 (num, reset, uptwo3, col3G[5], col3O[6]);
	targetLight c3r7 (num, reset, uptwo3, col3O[6], col3G[7]);
	
	rowRegularLight s3 (num, reset, col3G[7], a3);
	missLight miss3 (clk[whichClock], reset, num3, a3, downtwo31);
	
	scoreTracker col3 (clk[whichClock], reset, right, col3G[7], col3O[6], uptwo3, downtwo3, upone3);
	
	// combine all values values
	assign upTwo = uptwo0 | uptwo1 | uptwo2 | uptwo3;
	assign upOne = upone0 | upone1 | upone2 | upone3;
	assign downTwo = downtwo0 | downtwo1 | downtwo2 | downtwo3 | downtwo01 | downtwo11 | downtwo21 | downtwo31;
//   assign downTwo = downtwo0 | downtwo1 | downtwo2 | downtwo3;


	// SCORE COUNT
	counter0 d0 (clk[whichClock], reset, upOne, upTwo, downTwo, 0, dig3, dig2, dig1, dig0, carryUp0, carryDown0);
	counter0 d1 (clk[whichClock], reset, carryUp0, 0, 0, carryDown0, 1, 1, 1, dig1, carryUp1, carryDown1);
	counter0 d2 (clk[whichClock], reset, carryUp1, 0, 0, carryDown1, 1, 1, 1, dig2, carryUp2, carryDown2);
	counter3 d3 (clk[whichClock], reset, carryUp2, carryDown2, dig3);

	// DISPLAY SCORE
	scoreDisplay hex0 (dig0, HEX0);
	scoreDisplay hex1 (dig1, HEX1);
	scoreDisplay hex2 (dig2, HEX2);
	scoreDisplay hex3 (dig3, HEX3);
	
	// LED
	redLED lr(clk[21], reset, LED);
	redLED lg(clk[21], reset, LEDG);
	assign LLED[0] = clk[23];
	assign LLED[1] = ~clk[23];
	
endmodule
	