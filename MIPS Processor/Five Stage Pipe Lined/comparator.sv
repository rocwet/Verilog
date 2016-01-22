/* NAME					|	comparator.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  early comparator to decide whether to branch
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	Da 					|  IN [31:0]			|  value stored in register rs
	Db  	 				|  IN	[31:0]			|  value stored in register rt
	zero					|  OUT 					|  zero flag, 0: same, 1: different
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 4: MIPS Pipelined CPU
	CLASS					| EE 471
	DATE					| 03/13/2015
	#################################################################################################
*/ 
module comparator (Da, Db, zero);
	output zero;
	input [31:0] Da, Db; 
	
	wire [31:0] xnorOut; 
	wire [7:0] and4; 
	wire [1:0] and44; 
	
	
	//xnor
	genvar e;
	generate
		for(e = 0; e < 32; e++) begin: xnordadb
			xnor xnordadb (xnorOut[e], Da[e], Db[e]);
		end
	endgenerate
	
	//and each bit together 
	and a1 (and4[0], xnorOut[0], xnorOut[1], xnorOut[2], xnorOut[3]); 
	and a2 (and4[1], xnorOut[4], xnorOut[5], xnorOut[6], xnorOut[7]);
	and a3 (and4[2], xnorOut[8], xnorOut[9], xnorOut[10], xnorOut[11]); 
	and a4 (and4[3], xnorOut[12], xnorOut[13], xnorOut[14], xnorOut[15]); 	
	and a5 (and4[4], xnorOut[16], xnorOut[17], xnorOut[18], xnorOut[19]); 
	and a6 (and4[5], xnorOut[20], xnorOut[21], xnorOut[22], xnorOut[23]);
	and a7 (and4[6], xnorOut[24], xnorOut[25], xnorOut[26], xnorOut[27]); 
	and a8 (and4[7], xnorOut[28], xnorOut[29], xnorOut[30], xnorOut[31]); 	
	
	and aa1 (and44[0], and4[0], and4[1], and4[2], and4[3]);
	and aa2 (and44[1], and4[4], and4[5], and4[6], and4[7]);
	
	and aaa (zero, and44[0], and44[1]);

	endmodule
	