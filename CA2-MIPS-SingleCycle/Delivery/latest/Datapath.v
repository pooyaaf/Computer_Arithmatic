`timescale 1ps/1ps
module Datapath (
	clk,//from TB
    rst,//from TB
    inst,//from TB
    inputDataMemData,//from TB
    RegDst,//from controller
    DataWrite,//from controller
    RegWrite,//from controller
    operation,//from controller
    ALUSrc,//from controller
    MemtoReg,//from controller
    PCSrc,//from controller
    jump,//from controller
    jr,//from controller
    ALUZeroFlag,//to controller
    outputDataMem,//to TB
    dataMemAddress,//to TB
    instructionMemAddress//to TB
	);
    
    input clk, rst;
    input [31:0] inst;
    input [31:0] inputDataMemData;
    input [1:0] RegDst;
    input [1:0] DataWrite;
    input RegWrite;
    input ALUSrc;
    input MemtoReg;
    input PCSrc;
    input [2:0] operation;
    input jump;
    input jr;

    output ALUZeroFlag;
    output [31:0] outputDataMem;
    output [31:0] dataMemAddress;
    output [31:0] instructionMemAddress; 

    wire [31:0] PCout;
    wire [31:0] pcStepAdder;
    wire [31:0] ReadData1, ReadData2;
    wire [31:0] SignExtended;
    wire [31:0] aluOut;
    wire [31:0] muxDataMemALU;
            
    Adder DP_PCAdderPCStep(.a(32'd4), .b(PCout), .result(pcStepAdder));

	DPRegisterFile DP_RFTemp(.clk(clk), .rst(rst), .inst(inst), .RegDst(RegDst),
		.DataWrite(DataWrite), .RegWrite(RegWrite), .muxDataMemALU(muxDataMemALU),
		.pcStepAdder(pcStepAdder), .aluOut(aluOut), .ReadData1(ReadData1), .ReadData2(ReadData2));
    
    SignExt DP_SignExtend(.inputData(inst[15:0]), .outputData(SignExtended));
    
    DPALUContents DP_ALUcontents(.ReadData1(ReadData1),.ReadData2(ReadData2),.SignExtended(SignExtended),
		.operation(operation),.ALUSrc(ALUSrc),.aluOut(aluOut),.ALUZeroFlag(ALUZeroFlag));
    
    Multiplexer2i1o #(32) MUX_ALUandDataMemory(.i0(aluOut), .i1(inputDataMemData), .selector(MemtoReg), .out(muxDataMemALU));
    
	DPPCJumper DP_FinalPCAddr(.clk(clk), .rst(rst), .inst(inst), .SignExtended(SignExtended), .pcStepAdder(pcStepAdder),
    	.PCSrc(PCSrc), .ReadData1(ReadData1), .jump(jump), .jr(jr), .PCout(PCout));
    
    assign instructionMemAddress = PCout;
    assign dataMemAddress = aluOut;
    assign outputDataMem = ReadData2;
    
endmodule
