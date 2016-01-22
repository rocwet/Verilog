/* Instruction memory module.  Change the $readmemb line to have the name of the program you want to load */
module InstructionMem(instruction, address);
	input [31:0] address;
	output [31:0] instruction;
	reg [31:0]instrmem[1023:0];
	reg [31:0] temp;

	buf #1000 buf0(instruction[0],temp[0]),
		buf1(instruction[1],temp[1]),
	 	buf2(instruction[2],temp[2]),
	 	buf3(instruction[3],temp[3]),
	 	buf4(instruction[4],temp[4]),
	 	buf5(instruction[5],temp[5]),
	 	buf6(instruction[6],temp[6]),
	 	buf7(instruction[7],temp[7]),
	 	buf8(instruction[8],temp[8]),
	 	buf9(instruction[9],temp[9]),
	 	buf10(instruction[10],temp[10]),
	 	buf11(instruction[11],temp[11]),
	 	buf12(instruction[12],temp[12]),
	 	buf13(instruction[13],temp[13]),
	 	buf14(instruction[14],temp[14]),
	 	buf15(instruction[15],temp[15]),
	 	buf16(instruction[16],temp[16]),
	 	buf17(instruction[17],temp[17]),
	 	buf18(instruction[18],temp[18]),
	 	buf19(instruction[19],temp[19]),
	 	buf20(instruction[20],temp[20]),
	 	buf21(instruction[21],temp[21]),
	 	buf22(instruction[22],temp[22]),
	 	buf23(instruction[23],temp[23]),
	 	buf24(instruction[24],temp[24]),
	 	buf25(instruction[25],temp[25]),
	 	buf26(instruction[26],temp[26]),
	 	buf27(instruction[27],temp[27]),
	 	buf28(instruction[28],temp[28]),
	 	buf29(instruction[29],temp[29]),
	 	buf30(instruction[30],temp[30]),
	 	buf31(instruction[31],temp[31]);

	always @(*) begin
		temp = instrmem[address/4];
	end


//	initial begin
//		$readmemb("test00_xori_jump.txt", instrmem);
//	end
//	
//	initial begin
//		$readmemb("test01_add.txt", instrmem);
//	end
//	
//	initial begin
//		$readmemb("test02_sub.txt", instrmem);
//	end
//	
//	initial begin
//		$readmemb("test03_j_jr.txt", instrmem);
//	end
//	
//	initial begin
//		$readmemb("test04_lw_sw.txt", instrmem);
//	end
//	
//	initial begin
//		$readmemb("test05_bne.txt", instrmem);
//	end
//	
//	initial begin
//		$readmemb("test06_forwarding.txt", instrmem);
//	end
//	
	initial begin
		$readmemb("test07_Sorter.txt", instrmem);
	end
//	
//	initial begin
//		$readmemb("test08_slt.txt", instrmem);
//	end

endmodule

module instrmemstimulus();

	reg [31:0] address;
	wire [31:0] instruction;

	parameter ClockDelay = 10000;

	InstructionMem dut(.instruction, .address);

	initial begin
		address = 32'd0;	#(ClockDelay);
		address = 32'd4;	#(ClockDelay);
		address = 32'd8;	#(ClockDelay);
		address = 32'd12;	#(ClockDelay);
		address = 32'd16;	#(ClockDelay);
		address = 32'd20;	#(ClockDelay);
		address = 32'd24;	#(ClockDelay);
		address = 32'd28;	#(ClockDelay);
		$Stop;
	end
endmodule