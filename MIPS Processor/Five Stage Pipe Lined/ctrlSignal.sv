/* NAME					|	ctrlSignal.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  determine the control signal from the op and funct bits
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	branch				|	OUTPUT 				|	branch flag
	jump			   	|	OUTPUT 				|	jump flag
	RegDst				|	OUTPUT 				|	RegDst control signal
	RegWr			   	|	OUTPUT 				|	RegWr control signal
	ALUSrc				|	OUTPUT 				|	ALUSrc control signal
	MemWr					|	OUTPUT 				|	MemWr control signal
	MemToReg          |	OUTPUT 				|	MemToReg control signal
	jumpR             |	OUTPUT 				|	jumpR control signal
	ALUcntrl          |	OUTPUT [1:0]		|	ALUcntrl: +: 00   -:10    xor: 01   slt:11
	op						| 	IN	[5:0]			   | 	Top 6 bits of the instruction
	funct					| 	IN	[5:0]			   | 	Bottom 6 bits of the instruction
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 3: MIPS Single-Cycle CPU
	CLASS					| EE 471
	DATE					| 02/17/2015
	#################################################################################################
*/ 
module ctrlSignal (op, funct, branch, jump, RegDst, RegWr, ALUSrc, ALUcntrl, MemWr, MemToReg, jumpR);
	input [5:0] op, funct; 
	output reg branch, jump, RegDst, RegWr, ALUSrc, MemWr, MemToReg, jumpR; 
	output reg [1:0]  ALUcntrl;
	
	//state encoding
	//OP Code: +: 00   -:10    xor: 01   slt:11
  parameter [5:0] bne = 6'b000101, j = 6'b000010, lw = 6'b100011, sw = 6'b101011, xori = 6'b001110, add = 6'b100000, jr = 6'b001000,
			   slt = 6'b101010, sub = 6'b100010;
		
	 always @(*) begin
		if (op == 6'b0) begin
			case (funct)
				 add: begin branch = 1'b0; jump = 1'b0; RegDst = 1'b1; RegWr = 1'b1; ALUSrc = 1'b0; ALUcntrl = 2'b00; MemWr = 1'b0; MemToReg = 1'b0; jumpR = 1'b0; end
				 jr:  begin branch = 1'bX; jump = 1'b0; RegDst = 1'bX; RegWr = 1'b0; ALUSrc = 1'bX; ALUcntrl = 2'bXX; MemWr = 1'b0; MemToReg = 1'bX; jumpR = 1'b1; end
				 slt: begin branch = 1'b0; jump = 1'b0; RegDst = 1'b1; RegWr = 1'b1; ALUSrc = 1'b0; ALUcntrl = 2'b11; MemWr = 1'b0; MemToReg = 1'b0; jumpR = 1'b0; end
				 sub: begin branch = 1'b0; jump = 1'b0; RegDst = 1'b1; RegWr = 1'b1; ALUSrc = 1'b0; ALUcntrl = 2'b10; MemWr = 1'b0; MemToReg = 1'b0; jumpR = 1'b0; end
				default: begin branch = 1'b0; jump = 1'b0; RegDst = 1'bX; RegWr = 1'bX; ALUSrc = 1'bX; ALUcntrl = 2'bXX; MemWr = 1'bX; MemToReg = 1'bX; jumpR = 1'b0; end
			endcase
		end
		else begin 
			case (op)
				 bne: begin branch = 1'b1; jump = 1'b0; RegDst = 1'bX; RegWr = 1'b0; ALUSrc = 1'b0; ALUcntrl = 2'b10; MemWr = 1'b0; MemToReg = 1'bX; jumpR = 1'b0; end
				 j:   begin branch = 1'bX; jump = 1'b1; RegDst = 1'bX; RegWr = 1'b0; ALUSrc = 1'bX; ALUcntrl = 2'bXX; MemWr = 1'b0; MemToReg = 1'bX; jumpR = 1'b0; end
				 lw:  begin branch = 1'b0; jump = 1'b0; RegDst = 1'b0; RegWr = 1'b1; ALUSrc = 1'b1; ALUcntrl = 2'b00; MemWr = 1'b0; MemToReg = 1'b1; jumpR = 1'b0; end
				 sw:  begin branch = 1'b0; jump = 1'b0; RegDst = 1'bX; RegWr = 1'b0; ALUSrc = 1'b1; ALUcntrl = 2'b00; MemWr = 1'b1; MemToReg = 1'bX; jumpR = 1'b0; end
				 xori: begin branch = 1'b0; jump = 1'b0; RegDst = 1'b0; RegWr = 1'b1; ALUSrc = 1'b1; ALUcntrl = 2'b01; MemWr = 1'b0; MemToReg = 1'b0; jumpR = 1'b0; end
				 default: begin branch = 1'b0; jump = 1'b0; RegDst = 1'bX; RegWr = 1'bX; ALUSrc = 1'bX; ALUcntrl = 2'bXX; MemWr = 1'bX; MemToReg = 1'bX; jumpR = 1'b0; end
			endcase
		end 

	end 	 
	
endmodule

module ctrlSignal_testbench();
	reg [5:0] op, funct; 
	wire branch, jump, RegDst, RegWr, ALUSrc, MemWr, MemToReg, jumpR; 
	wire [1:0]  ALUcntrl;
	
	ctrlSignal dut (.op, .funct, .branch, .jump, .RegDst, .RegWr, .ALUSrc, .ALUcntrl, .MemWr, .MemToReg, .jumpR);
	
	initial begin
	op = 6'b000000; funct = 6'b100000; #10; //add
	op = 6'b000000; funct = 6'b001000; #10; //jr
	op = 6'b100011; funct = 6'b111111; #10; //lw
	op = 6'b000101; funct = 6'b010111; #10; //bne
	op = 6'b000000; funct = 6'b100010; #10; //sub
	op = 6'b101011; funct = 6'b111000; #10; //sw	
	op = 6'b001110; funct = 6'b000000; #10; //xori
	op = 6'b101011; funct = 6'b111111; #10; //sw
	op = 6'b000101; funct = 6'b101010; #10; //bne
	op = 6'b000010; funct = 6'b000000; #10; //j
	op = 6'b000000; funct = 6'b101010; #10; //slt
	op = 6'b011110; funct = 6'b001010; #10; //none
	op = 6'b001110; funct = 6'b111111; #10; //xori
	op = 6'b000000; funct = 6'b101010; #10; //slt	
	end
	
endmodule
