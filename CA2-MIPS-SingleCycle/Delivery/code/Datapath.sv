module Datapath (
	clk,
    rst,
    inst_adr,
    inst,
    data_adr,
    data_out,
    data_in,
    RegDst,
    MemtoReg,
    ALUSrc,
    PCSrc,
    alu_operation,
    RegWrite,
    zero,
    dataToWrite,
    jr,
    jmp);
    
    	input  clk, rst;
    	output [31:0] inst_adr;
    	input  [31:0] inst;
    	output [31:0] data_adr;
    	output [31:0] data_out;
    	input  [31:0] data_in;
    	input MemtoReg, ALUSrc, PCSrc, RegWrite;
    	input  [2:0] alu_operation;
    	output zero;
    
    	//new signals coming from controller;
    	input jr, jmp;
    	//slti;
    	input [1:0] dataToWrite,RegDst;
    
    	wire [31:0] pc_out;
    	wire [31:0] adder1_out;
    	wire [31:0] ReadData1, ReadData2;
    	wire [31:0] SignExt_out;
    	wire [31:0] mux2_out;
    	wire [31:0] aluOut;
    	wire [31:0] adder2_out;
    	wire [31:0] shl2_out;
    	wire [31:0] mux3_out;
    	wire [31:0] mux4_out;
    
    	wire [4:0]  mux1_out;
    
    	//new nets
    	wire [31:0] mux5_out;
    	wire [27:0] shl26_out;
    	wire [31:0] in0MUX6;
    	wire [31:0] mux6_out;
    	wire [31:0] mux7_out;
    
    	Adder ADDER_1(pc_out , 32'd4, 1'b0, adder1_out);
    
    	mux3to1 #(32) MUX_1(inst[20:16], inst[15:11], 5'b11111, RegDst, mux1_out);
    
    	//adding mux5 for writeData in RF
    	mux3to1 #(32) MUX_5(mux4_out,  adder1_out, aluOut, dataToWrite, mux5_out);
    
    	//set writeData input to mux5_out;
    	RegisterFile  RF(mux5_out, inst[25:21], inst[20:16], mux1_out, RegWrite, rst, clk, ReadData1, ReadData2);
    
    	SignExt sign_ext(inst[15:0], SignExt_out);
    
    	mux2to1 #(32) MUX_2(ReadData2, SignExt_out , ALUSrc, mux2_out);
    
    	ALU alu(ReadData1, mux2_out, alu_operation, aluOut, zero);
    
    	SHL2 #(32) shl2(SignExt_out, shl2_out);
    
    	Adder ADDER_2(adder1_out, shl2_out, 1'b0, adder2_out);
    
    	mux2to1 #(32) MUX_3(adder1_out, adder2_out, PCSrc, mux3_out);
    
    	mux2to1 #(32) MUX_4(aluOut, data_in, MemtoReg, mux4_out);
    
    	//adding MUX6
    	SHL2 #(28) shl26(inst[25:0], shl26_out);
    	assign in0MUX6 = {adder1_out[31:28], shl26_out};
    
    	mux2to1 #(32) MUX_6(in0MUX6, ReadData1, jr, mux6_out);
    
    	//adding MUX7
    	mux2to1 #(32) MUX_7(mux3_out, mux6_out, jmp, mux7_out);
    
    	register #(32) PC(mux7_out, rst, 1'b1, clk, pc_out);
    
    	assign inst_adr = pc_out; //instruction generated for  
    	assign data_adr = aluOut;  //Address in data_memory where data should be written
    	assign data_out = ReadData2; //Value that should be written in data_memory
    
endmodule
