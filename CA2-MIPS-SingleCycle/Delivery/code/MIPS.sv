`timescale 1ns/1ns
module MIPS (
	rst, 
	clk,
    inst,
    data_in,
    inst_adr,
    data_adr,
    data_out,
    MemRead, 
	MemWrite);
    	input rst, clk;
    	input  [31:0] inst;
		input  [31:0] data_in;
    	output [31:0] inst_adr;
    	output [31:0] data_adr;
    	output [31:0] data_out;
    	output MemRead, MemWrite;
    	
    	wire MemtoReg, ALUsrc, PCSrc, RegWrite, zero;
    	wire [2:0] operation; //alu operation (ALU Controller's input)
    
    	//new signals
    	wire [1:0] RegDst;
    	wire  jr, jmp;
    	wire [1:0] dataToWrite;
		wire [2:0] alu_operation;
    
    	Datapath DP(clk, rst, inst_adr, inst, data_adr, data_out, data_in,
    	RegDst, MemtoReg, ALUsrc, PCSrc, alu_operation, RegWrite, zero,
    	dataToWrite, jr, jmp
    	);
    
    	Controller CTRL(inst[31:26], inst[5:0], zero, RegDst, MemtoReg, RegWrite,
    	ALUsrc, MemRead, MemWrite, PCSrc, alu_operation,dataToWrite, jr, jmp
    	);
    
endmodule
