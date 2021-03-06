/* NAME					|	instructionFetchUnit.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  fetches instructions
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	instr					|	OUTPUT [31:0]		|	the instructions to follow
	branch				| 	IN						| 	branch flag to perform branches
	jump					| 	IN						|  jump flag to perform jumps
	jumpR					| 	IN						|  jump to register flag to perform jumps to register
	zero 					|  IN						|  zero flag to perform control signal with branches
	clk 					|  IN						|  the clk: perform the tasks in single cycle
	reset 				|  IN						|  the reset signal, initialize the PC counter
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 3: MIPS Single-Cycle CPU
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module instructionFetchUnit(instr, branch, jump, zero, clk, reset, Da, jumpR, imm16_2, addOneEnable, instr2);

	input branch, jump, jumpR;
	input [31:0] Da, instr2;
	input [15:0] imm16_2;
	input clk, zero, reset, addOneEnable;
	output [31:0] instr;
	wire [29:0] outMuxb, outSum, outMuxj, outMuxja, outConcate, PC, stall;
	wire [31:0] outSignExtend;
	wire andOut, nzero; 

	//PC 
	genvar a;
	generate
		for(a = 0; a < 30; a++) begin: eachPCbit
			D_FF d0 (.q(PC[a]), .d(outMuxj[a]), .reset, .clk);
		end
	endgenerate
	

	//Concatenate
	genvar w;
	generate
		for(w = 0; w < 26; w++) begin: eachConcate
			buf b1 (outConcate[w], instr2[w]);  
		end
	endgenerate
	
	genvar t;
	generate
		for(t = 26; t < 30; t++) begin: eachConcateTop
			buf b1 (outConcate[t], PC[t]);  
		end
	endgenerate
	
	//fetch unit
	signExtend s1 (.out(outSignExtend), .in(imm16_2));
	not n1 (nzero, zero);
	and a1 (andOut, branch, nzero);
	
	thirtyBitAdder t1 (.SUM(outSum), .A(PC), .B(outMuxb), .addOneEnable); //addOneEnable true when jump, branch, and lw
		
	genvar i;
	generate
		for(i = 0; i < 30; i++) begin: eachBitSE
			mux2to1 m1 (.IN({outSignExtend[i], 1'b0}), .OUT(outMuxb[i]), .SEL(andOut)); 
		end
	endgenerate

	
	genvar j; 
	generate 
		for(j = 0; j < 30; j++) begin: eachBitConcate
			mux2to1 m2 (.IN({outConcate[j], outSum[j]}), .OUT(outMuxja[j]), .SEL(jump));
		end
	endgenerate 
	
	genvar z; 
	generate 
		for(z = 0; z < 30; z++) begin: eachBitConcate1
			mux2to1 m3 (.IN({Da[z+2], outMuxja[z]}), .OUT(outMuxj[z]), .SEL(jumpR));
		end
	endgenerate 

	//instruction memory
	InstructionMem i1 (.instruction(instr), .address({PC, 2'b00}));
	
endmodule
	
module instructionFetchUnit_testbench();
	reg branch, jump, clk, zero, reset, jumpR;
	reg [31:0] Da;
	wire [31:0] instr;
	
	instructionFetchUnit dut (.instr, .branch, .jump, .zero, .clk, .reset, .Da, .jumpR);
	
	parameter period = 1000;

 initial clk = 1;
	 always begin
			#(period/2);
			clk = ~clk;
	 end  
 
 initial begin
 reset <= 1; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0;    @(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 1; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 reset <= 0; jump <= 0; branch <= 0; zero <= 0; 	@(posedge clk);
 $stop();
 end 
endmodule
	

	