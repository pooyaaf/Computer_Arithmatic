`timescale 1ps/1ps
module DPPCJumper (
    clk,
    rst,
    inst,
    SignExtended,
    pcStepAdder,
    PCSrc,
    ReadData1,
    jump,
    jr,
    PCout
    );

	input  clk, rst;
	input [31:0] inst;
	input [31:0] SignExtended;
    input [31:0] pcStepAdder;
	input PCSrc;
	input [31:0] ReadData1;
    input jr, jump;

    output [31:0] PCout;

    wire [31:0] signExtenShifted;
    wire [31:0] InstAddr;
    wire [31:0] newPCsrc;
    wire [31:0] PCAddressJump;
	wire [31:0] newPCAddr;


    ShiftLeft #(32) ShiftLeft(.inputData(SignExtended), .outputData(signExtenShifted));
    
    Adder ADDER_2(.a(pcStepAdder), .b(signExtenShifted), .result(PCAddressJump));
    
    Multiplexer2i1o #(32) ISNormalPC(.i0(pcStepAdder), .i1(PCAddressJump), .selector(PCSrc), .out(newPCsrc));
        
    PCSignExt InstAddressToJump(.inst(inst), .pcStepAdder(pcStepAdder), .ReadData1(ReadData1),
        .jr(jr), .InstAddr(InstAddr));
        
    Multiplexer2i1o #(32) newPCAddress(.i0(newPCsrc), .i1(InstAddr), .selector(jump), .out(newPCAddr));
    
	Register #(32) PC(.clk(clk), .rst(rst), .ld(1'b1), .inputData(newPCAddr), .outputData(PCout));
    
    
endmodule