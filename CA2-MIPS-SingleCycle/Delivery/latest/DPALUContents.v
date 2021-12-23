`timescale 1ps/1ps
module DPALUContents (
    ReadData1,//from datapath
    ReadData2,//from datapath
    SignExtended,//from datapath
    operation,//from controller in MIPS 
    ALUSrc,//from controller in MIPS
    aluOut,//to datapath
    ALUZeroFlag//to controller
    );

	input [31:0] ReadData1;
    input [31:0] ReadData2;
    input [31:0] SignExtended;
	input [2:0] operation;
	input ALUSrc;
    
    output [31:0] aluOut;
	output ALUZeroFlag;

	wire [4:0]  muxWriteReg;
	wire [31:0] muxWriteData;
	wire [31:0] ALUinput2;

    Multiplexer2i1o #(32) ALUinput2MUX(.i0(ReadData2), .i1(SignExtended) , .selector(ALUSrc), .out(ALUinput2));
    
	ALU alu(.a(ReadData1), .b(ALUinput2), .operation(operation), .ALUZeroFlag(ALUZeroFlag), .aluOut(aluOut));
   
endmodule