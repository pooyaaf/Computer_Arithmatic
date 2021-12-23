`timescale 1ps/1ps
module PCSignExt (
    inst,
    pcStepAdder,
    ReadData1,
    jr,
    InstAddr
    );

	input [31:0] inst;
    input [31:0] pcStepAdder;
	input [31:0] ReadData1;
    input jr;

    output [31:0] InstAddr;
    
    wire [31:0] newPCsrc;
    wire [31:0] PCAddressJump;
    wire [27:0] instAddrSL;
    wire [31:0] newJumpAddr;

    ShiftLeft #(28) SLtheInstructionAddress(.inputData(inst[25:0]), .outputData(instAddrSL));
    
    assign newJumpAddr = {pcStepAdder[31:28], instAddrSL};
    
    Multiplexer2i1o #(32) MUX_6(newJumpAddr, ReadData1, jr, InstAddr);    
    
endmodule