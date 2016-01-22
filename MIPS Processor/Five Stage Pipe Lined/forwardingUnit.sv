/* NAME					|	forwardingUnit.sv
	-------------------------------------------------------------------------------------------------
	DESCRIPTION       |  forwanding control logic
 ---------------------------------------------------------------------------------------------------
	PARAMETERS			|	TYPE					|	DESCRIPTION					
 ---------------------------------------------------------------------------------------------------
	rs 					|  IN [4:0]			   |  register rs in DECODE
	rt  	 				|  IN	[4:0]			   |  register rt in DECODE
	RegWr3				|  IN					   |  enable alu RegWr 
	RegWr4				|  IN					   |  enable memory RegWr
	RegDest3				|  IN						|  RegDest in alu
	RegDest4				|  IN						|  RegDest in memory
	Dest3			   	|  IN [9:0]          |  Rd or Rt from alu: 9-5 is Rt and 4-0 is Rd
	Dest4			   	|  IN [9:0]          |  Rd or Rt from memory: 9-5 is Rt and 4-0 is Rd
	DaMuxCntrl			|  OUT [1:0]         |  control signal for forwarding mux da
	DbMuxCntrl			|  OUT [1:0]         |  control signal for forwarding mux db
	#################################################################################################
	AUTHOR            | Minhhue H Khuu && Tzu-Wei Chuang
	ASSIGNMENT			| Lab 4: MIPS Pipelined CPU
	CLASS					| EE 471
	DATE					| 03/13/2015
	#################################################################################################
*/ 
module forwardingUnit (DaMuxCntrl, DbMuxCntrl, rs, rt, Dest3, Dest4, RegWr3, RegWr4, RegDest3, RegDest4); 
	output reg [1:0] DaMuxCntrl, DbMuxCntrl; 
	input [4:0] rs, rt; 
	input [9:0] Dest3, Dest4; 
	input RegWr3, RegWr4, RegDest3, RegDest4; 
	
	parameter [1:0] DwOut5 = 2'b10, ALUOut4 = 2'b01, D = 2'b00;
	
	// Forward Da
	always @(*) begin 
		if(RegWr3 & (((((Dest3[9:5] == rs))&(!RegDest3)&(Dest3[9:5] != 5'b0)) | (((Dest3[4:0] == rs))&(RegDest3)&(Dest3[4:0] != 5'b0)))))
			DaMuxCntrl = ALUOut4;
		else if (RegWr4 & ((Dest4[9:5] == rs)&(!RegDest4)&(Dest4[9:5] != 5'b0)) | ((Dest4[4:0] == rs)&(RegDest4)&(Dest4[4:0] != 5'b0)))
			DaMuxCntrl = DwOut5;
		else 
			DaMuxCntrl = D;
	end
	
	// Forward Db
	always @(*) begin 
		if(RegWr3 & (((((Dest3[9:5] == rt))&(!RegDest3)&(Dest3[9:5] != 5'b0)) | (((Dest3[4:0] == rt))&(RegDest3)&(Dest3[4:0] != 5'b0)))))
			DbMuxCntrl = ALUOut4;
		else if (RegWr4 & ((Dest4[9:5] == rt)&(!RegDest4)&(Dest4[9:5] != 5'b0)) | ((Dest4[4:0] == rt)&(RegDest4)&(Dest4[4:0] != 5'b0)))
			DbMuxCntrl = DwOut5;
		else 
			DbMuxCntrl = D;
	end
	
	
	endmodule

	//XORI Dest4[9:5], rs, imm (i-type) two cycles ago
	//XORI Dest3[9:5], rs, imm (i-type) one cycle ago
	//XORI rt, rs, imm 			(i-type) Now
	
	//XORI Dest4[9:5], rs, imm (i-type) two cycles ago
	//XORI Dest3[9:5], rs, imm (i-type) one cycle ago
	//Add  rd, rs, rt  			(r-type) Now
		
	//XORI Dest4[9:5], rs, imm (i-type) two cycles ago
	//Add  Dest3[4:0], rs, rt  (r-type) one cycle ago
	//XORI rt, rs, imm 			(i-type) Now
	
	//XORI Dest4[9:5], rs, imm (i-type) two cycles ago
	//Add  Dest3[4:0], rs, rt  (r-type) one cycle ago
	//Add  rd, rs, rt  			(r-type) Now

	//Add  Dest4[4:0], rs, rt  (r-type) two cycles ago
	//XORI Dest3[9:5], rs, imm (i-type) one cycle ago
	//Add  rd, rs, rt  			(r-type) Now

	//Add  Dest4[4:0], rs, rt  (r-type) two cycles ago
	//XORI Dest3[9:5], rs, imm (i-type) one cycle ago
	//XORI rt, rs, imm 			(i-type) Now
	
	//Add  Dest4[4:0], rs, rt  (r-type) two cycles ago
	//Add  Dest3[4:0], rs, rt  (r-type) one cycle ago
	//Add  rd, rs, rt  			(r-type) Now

	//Add  Dest4[4:0], rs, rt  (r-type) two cycles ago
	//Add  Dest3[4:0], rs, rt  (r-type) one cycle ago
	//XORI rt, rs, imm 			(i-type) Now
