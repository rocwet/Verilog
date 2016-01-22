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
	ASSIGNMENT			| Lab 4: MIPS Pipelined CPU
	CLASS					| EE 471
	DATE					| 03/13/2015
	#################################################################################################
*/ 
module CPU (clk, reset);
		
	// ports
	input clk, reset;
	
	// wires
	wire RegWr2, RegWr3, RegWr4, RegWr5, ALUSrc2, ALUSrc3, MemWr2, MemWr3, MemWr4, MemToReg3, MemToReg4, RegDest3, RegDest4;
	wire zero, somewhere, nzero, andOut, addOneEnable, Branch2, Jump2,  jumpR2; 
	wire [1:0] ALUCtrl2, ALUCtrl3, DestDa, DestDb;
	wire [4:0] Rs2, Rt2, Rd2, Aw2, Aw3, Aw4, Aw5;
	wire [5:0] Op2, funct2;
	wire [15:0] Imm16_2, Imm16_3;
	wire [31:0] writeToReg, signExtendImm16_3, ALUSrcOut, ALUOut, ALUOut4, memDataOut;
	wire [31:0] instructions, instructions2, instructions3, instructions4; 
	wire [31:0] Da, Da2, Da3, Db, Db2, Db3, Db4, DwOut5; 

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		
	//IFU: stage 1
	instructionFetchUnit ifu (.instr(instructions), .branch(Branch2), .jump(Jump2), .zero, .clk, .reset, .Da(Da2),
										.jumpR(jumpR2), .imm16_2(Imm16_2), .addOneEnable, .instr2(instructions2)); 
	
	//PC for branch
	not notzero (nzero, zero);
	and andOut1 (andOut, Branch2, nzero);
	buf o01 (addOneEnable, andOut);
	
	//pipelined stage 1
	iF_iD stage1(.instrOut(instructions2), .instrIn(instructions), .clk, .reset);
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Register File: stage 2	
	retrieve splitInstructions2 (.funct(funct2), .Op(Op2), .Imm16(Imm16_2), .Rd(Rd2), .Rt(Rt2), .Rs(Rs2), .instructions(instructions2));
	
	ctrlSignal cs2 (.op(Op2), .funct(funct2), .branch(Branch2), .jump(Jump2), .RegDst(RegDest2), 
						.jumpR(jumpR2), .RegWr(RegWr2), .ALUSrc(ALUSrc2), .ALUcntrl(ALUCtrl2), .MemWr(MemWr2), .MemToReg(MemToReg2));
						
	//Choosing write register 
	genvar e;
	generate
		for(e = 0; e < 5; e++) begin: chooseRegDest_Bits
			mux2to1 chooseRegDest (.IN({Rd2[e], Rt2[e]}), .OUT(Aw2[e]), .SEL(RegDest2));
		end
	endgenerate
	
	//register file
	regfile regfile0 (.ReadData1(Da), .ReadData2(Db), .WriteData(DwOut5), .ReadRegister1(Rs2), .ReadRegister2(Rt2), 
							.WriteRegister(Aw5), .RegWrite(RegWr5), .clk(~clk));
	
	//Forwarding mux 1 for Da
	genvar t;
	generate
		for(t = 0; t < 32; t++) begin: chooseWhichDa
			mux4to1 chooseDa (.IN({writeToReg[t], ALUOut[t], Da[t]}), .OUT(Da2[t]), .SEL(DestDa)); 
		end
	endgenerate

	//Forwarding mux 1 for Db
	genvar s;
	generate
		for(s = 0; s < 32; s++) begin: chooseWhichDb
			mux4to1 chooseDb (.IN({writeToReg[s], ALUOut[s], Db[s]}), .OUT(Db2[s]), .SEL(DestDb));
		end
	endgenerate
	
	//Forwarding logic 
	forwardingUnit f11 (.DaMuxCntrl(DestDa), .DbMuxCntrl(DestDb), .rs(Rs2), .rt(Rt2), 
							.Dest3(instructions3[20:11]), .Dest4(instructions4[20:11]), .RegWr3(RegWr3), .RegWr4(RegWr4), .RegDest3(RegDest3), .RegDest4(RegDest4)); 
	
	comparator cc1 (.Da(Da2), .Db(Db2), .zero);
	
	//pipelined stage 2
	iD_eX stage2(.DaOut(Da3), .DbOut(Db3), .AwOut(Aw3), .DaIn(Da2), .DbIn(Db2), .AwIn(Aw2), .clk, .reset, .RegWrOut(RegWr3), .ALUSrcOut(ALUSrc3),
					.ALUcntrlOut(ALUCtrl3), .MemWrOut(MemWr3), .MemToRegOut(MemToReg3), .RegWrIn(RegWr2), .ALUSrcIn(ALUSrc2), .ALUcntrlIn(ALUCtrl2), 
					.MemWrIn(MemWr2), .MemToRegIn(MemToReg2), .instrOut(instructions3), .instrIn(instructions2), .RegDestOut(RegDest3), .RegDestIn(RegDest2)); 

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//ALU: stage 3
	signExtend s2 (.out(signExtendImm16_3), .in(instructions3[15:0]));
	
	//choosing ALU source, Db or Imm16
	genvar f;
	generate
		for(f = 0; f < 32; f++) begin: chooseALUSrc_Bits
			mux2to1 chooseALUSrc (.IN({signExtendImm16_3[f], Db3[f]}), .OUT(ALUSrcOut[f]), .SEL(ALUSrc3));
		end
	endgenerate
	
	//do ALU operation
	alu a1 (.Output(ALUOut), .zero(somewhere), .BussA(Da3), .BussB(ALUSrcOut), .ALUControl(ALUCtrl3)); 
	
	//pipelined stage 3
	eX_meM stage3 (.ALUOut(ALUOut4), .DbOut(Db4), .AwOut(Aw4), .ALUIn(ALUOut), .DbIn(Db3), .AwIn(Aw3), .clk, .reset, .RegWrOut(RegWr4),
						.MemWrOut(MemWr4), .MemToRegOut(MemToReg4), .RegWrIn(RegWr3), .MemWrIn(MemWr3), .MemToRegIn(MemToReg3), 
						.instrOut(instructions4), .instrIn(instructions3), .RegDestOut(RegDest4), .RegDestIn(RegDest3)); 
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	//memory file: stage 4
	dataMem d1 (.data(memDataOut), .address(ALUOut4), .writedata(Db4), .writeenable(MemWr4), .clk);
	
	//choose memory data out to register write
	genvar g;
	generate
		for(g = 0; g < 32; g++) begin: chooseMemoryDataToRegister_Bits
			mux2to1 chooseMemData (.IN({memDataOut[g], ALUOut4[g]}), .OUT(writeToReg[g]), .SEL(MemToReg4));
		end
	endgenerate

	//pipelined stage 4
	meM_wR stage4 (.DwOut(DwOut5), .AwOut(Aw5), .DwIn(writeToReg), .AwIn(Aw4), .clk, .reset, .RegWrOut(RegWr5), .RegWrIn(RegWr4)); 

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////	
endmodule 

	//CPU testbench
module CPU_testbench();
	reg clk, reset;
	
	CPU dut (.clk, .reset);
	
	parameter period = 10000;

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
	
