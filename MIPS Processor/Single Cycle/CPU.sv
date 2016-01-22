/* NAME					|	CPU.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  the top level of a single cycle CPU
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	clk 					|  IN						|  the clk: perform the tasks in single cycle
	reset 				|  IN						|  the reset signal, initialize the PC counter
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 3: MIPS Single-Cycle CPU
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module CPU (clk, reset);
		
	// ports
	input clk, reset;
	
	// wires
	wire RegDest, RegWr, ALUSrc, Branch, Jump, MemWr, MemToReg, jumpR;
	wire [1:0] ALUCtrl;
	wire [31:0] instructions, writeToReg, Da, Db, signExtendImm16, ALUSrcOut, ALUOut, memDataOut;
	
	wire [5:0] Op, funct;
	wire [4:0] Rs, Rt, Rd, Aw;
	wire [15:0] Imm16;
	wire zero;
	
	//Compute control signals
	ctrlSignal cs1 (.op(Op), .funct, .branch(Branch), .jump(Jump), .RegDst(RegDest), .RegWr, .ALUSrc, .ALUcntrl(ALUCtrl), .MemWr, .MemToReg, .jumpR);
	
	// IFU
	instructionFetchUnit ifu (.instr(instructions), .branch(Branch), .jump(Jump), .zero(zero), .clk, .reset, .Da, .jumpR);
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// retrieve Op, Rs, Rt, Rd, and Imm16
	genvar aaa;
	generate
		for(aaa = 0; aaa < 6; aaa++) begin: funct_copy
			buf b1 (funct[aaa], instructions[aaa]);  
		end
	endgenerate
	
	genvar aa;
	generate
		for(aa = 26; aa < 32; aa++) begin: Op_copy
			buf b1 (Op[aa-26], instructions[aa]);  
		end
	endgenerate
	
	genvar a;
	generate
		for(a = 0; a < 16; a++) begin: Imm16_copy
			buf b1 (Imm16[a], instructions[a]);  
		end
	endgenerate
	
	genvar b;
	generate
		for(b = 11; b < 16; b++) begin: Rd_copy
			buf b1 (Rd[b-11], instructions[b]);  
		end
	endgenerate
	
	genvar c;
	generate
		for(c = 16; c < 21; c++) begin: Rt_copy
			buf b1 (Rt[c-16], instructions[c]);  
		end
	endgenerate
	
	genvar d;
	generate
		for(d = 21; d < 26; d++) begin: Rs_copy
			buf b1 (Rs[d-21], instructions[d]);  
		end
	endgenerate
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// choosing write register 
	genvar e;
	generate
		for(e = 0; e < 5; e++) begin: chooseRegDest_Bits
			mux2to1 chooseRegDest (.IN({Rd[e], Rt[e]}), .OUT(Aw[e]), .SEL(RegDest));
		end
	endgenerate
	
	// register file
	regfile regfile0 (.ReadData1(Da), .ReadData2(Db), .WriteData(writeToReg), .ReadRegister1(Rs), .ReadRegister2(Rt), .WriteRegister(Aw), .RegWrite(RegWr), .clk);
	
	// signextend imm16
	signExtend s1 (.out(signExtendImm16), .in(Imm16));
	
	// choosing ALU source
	genvar f;
	generate
		for(f = 0; f < 32; f++) begin: chooseALUSrc_Bits
			mux2to1 chooseALUSrc (.IN({signExtendImm16[f], Db[f]}), .OUT(ALUSrcOut[f]), .SEL(ALUSrc));
		end
	endgenerate
	
	// do ALU operation
	alu a1 (.Output(ALUOut), .CarryOut(), .zero(zero), .overflow(), .negative(), .BussA(Da), .BussB(ALUSrcOut), .ALUControl(ALUCtrl));
	
	// memory file
	dataMem d1 (.data(memDataOut), .address(ALUOut), .writedata(Db), .writeenable(MemWr), .clk);
	
	// choose memory data out to register write
	genvar g;
	generate
		for(g = 0; g < 32; g++) begin: chooseMemoryDataToRegister_Bits
			mux2to1 chooseMemData (.IN({memDataOut[g], ALUOut[g]}), .OUT(writeToReg[g]), .SEL(MemToReg));
		end
	endgenerate


endmodule 

module CPU_testbench();
	reg clk, reset;
	
	CPU dut ( .clk, .reset);
	
	parameter period = 4000;

 initial clk = 1;
	 always begin
			#(period/2);
			clk = ~clk;
	 end  
 
 initial begin
  integer g; 
	  reset <= 1; @(posedge clk);
	  reset <= 0; @ (posedge clk);
	  for (g = 0; g < 1000; g++) begin
		 @(posedge clk);
	  end
 $stop();
 end 
 	
endmodule
	
