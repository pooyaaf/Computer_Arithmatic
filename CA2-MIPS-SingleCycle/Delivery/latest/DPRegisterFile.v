`timescale 1ps/1ps
module DPRegisterFile (
    clk,//from TB
    rst,//from TB
    inst,//from TB in instMem
    RegDst,//from controller
    DataWrite,//from controller
    RegWrite,//from controller
    muxDataMemALU,//from datapath
    pcStepAdder,///from datapath
    aluOut,//from datapath
    ReadData1,//to datapath
    ReadData2//to datapath
    );

	input  clk, rst;
	input [31:0] inst;
	input [1:0] DataWrite,RegDst;
	input RegWrite;
    input [31:0] muxDataMemALU;
    input [31:0] pcStepAdder;
    input [31:0] aluOut;

	output [31:0] ReadData1, ReadData2;

	wire [4:0]  muxWriteReg;
	wire [31:0] muxWriteData;

    //select between registers 5'b1 is reg31
	Multiplexer3i1o #(32) MUX_WRITEREG(.i0(inst[20:16]), .i1(inst[15:11]), .i2(5'b11111), .selector(RegDst), .out(muxWriteReg));
    
	//select between output of muxDataMemory &...  for writeData in RF
	Multiplexer3i1o #(32) MUX_WRITEDATA(.i0(muxDataMemALU), .i1(pcStepAdder), .i2(aluOut), .selector(DataWrite), .out(muxWriteData));
    
    //now every inputs of RF is ready
	RegisterFile  RF(.clk(clk), .rst(rst), .RegWrite(RegWrite), .ReadRegister1(inst[25:21]), .ReadRegister2(inst[20:16]), 
        .WriteRegister(muxWriteReg), .WriteData(muxWriteData), .ReadData1(ReadData1), .ReadData2(ReadData2));
    
endmodule