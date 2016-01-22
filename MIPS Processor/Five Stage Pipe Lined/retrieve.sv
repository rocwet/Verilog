/* NAME					|	retrieve.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  split instructions into useful data
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	instructions 		|  IN	[31:0]			|  instructions being read
	Rd						|  OUT [4:0]			|  destination register rd
	Rs						|  OUT [4:0]			|  register rt
	Rt						|  OUT [4:0]			|  register rs
	Imm16					|  OUT [15:0]			|  immediate 16 
	funct		  			|  OUT [5:0]			|  funct code to determine instruction type	
	op			  			|  OUT [5:0]			|  op code to determine instruction type
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 4: MIPS Pipelined CPU
	CLASS					| EE 471
	DATE					| 03/13/2015
	#################################################################################################
*/ 
module retrieve (funct, Op, Imm16, Rd, Rt, Rs, instructions);

	output [5:0] funct, Op;
	output [15:0] Imm16; 
	output [4:0] Rd, Rt, Rs; 
	input [31:0] instructions; 
		
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
	
	endmodule
	