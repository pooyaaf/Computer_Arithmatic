`timescale 1ps/1ps
module MIPS (
	rst, 
	clk,
    inst,
    inputDataMemData,
    instructionMemAddress,
    dataMemAddress,
    outputDataMem,
    MemRead, 
	MemWrite
	);

    input rst, clk;
    input  [31:0] inst;
	input  [31:0] inputDataMemData;
    output [31:0] instructionMemAddress;
    output [31:0] dataMemAddress;
    output [31:0] outputDataMem;
    output MemRead, MemWrite;
    	
    wire MemtoReg, ALUsrc, PCSrc, RegWrite, ALUZeroFlag;//MIPS signals
    wire [2:0] operation; //alu operation (ALU Controller's input)
    
    wire [1:0] RegDst;//our signals
    wire [1:0] DataWrite;//our signals
    wire  jr, jump;//our signals
     
    Datapath DP(.clk(clk), .rst(rst), .inst(inst), .inputDataMemData(inputDataMemData), .RegDst(RegDst),
    	.DataWrite(DataWrite), .RegWrite(RegWrite), .operation(operation), .ALUSrc(ALUsrc),
		.MemtoReg(MemtoReg), .PCSrc(PCSrc), .jump(jump), .jr(jr), .ALUZeroFlag(ALUZeroFlag),
		.outputDataMem(outputDataMem), .dataMemAddress(dataMemAddress), .instructionMemAddress(instructionMemAddress));

    
    Controller CTRL(.opcode(inst[31:26]), .RTfunction(inst[5:0]), .ALUZeroFlag(ALUZeroFlag), 
		.RegDst(RegDst), .DataWrite(DataWrite), .RegWrite(RegWrite), .operation(operation),
    	.ALUsrc(ALUsrc), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .MemRead(MemRead), .PCSrc(PCSrc), .jr(jr), .jump(jump));
    
endmodule
