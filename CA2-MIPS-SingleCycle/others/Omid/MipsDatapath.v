`timescale 1ns/1ns
module MipsDatapath(
    input clk,
    rst,
    RegDst,
    RegWrite,
    AluSrc,
    MemRead,
    MemWrite,
    MemToReg,
    Jump,
    Jumpr,
    Save,
    BranchJump,
    input [2:0] AluOperation,
    output [5:0] OpCode,
    Func,
    output Zero
);
    wire [4:0] w1, Wreg;
    wire [31:0] nextPC, currentPC, Wdata, Rdata1, Rdata2, ExtendedImm, Operand2, AluResult, w2, w3, w4, w5, w6, w7, inst;

    PC P(clk, rst, nextPC, currentPC);

    InstMemory IM(currentPC, inst);

    MUX #(5) M1(RegDst, inst[20:16], inst[15:11], w1);
    MUX #(5) M2(Save, w1, 5'd31, Wreg) ;

    RegisterFile RF(clk, rst, RegWrite, inst[25:21], inst[20:16], Wreg, Wdata, Rdata1, Rdata2);

    SignExtender SE(inst[15:0], ExtendedImm);

    MUX #(32) M3(AluSrc, Rdata2, ExtendedImm, Operand2);

    ALU A(Rdata1, Operand2, AluOperation, Zero, AluResult);

    DataMemory DM(MemRead, MemWrite, AluResult, Rdata2, w2);

    MUX #(32) M4(MemToReg, AluResult, w2, w7);
    MUX #(32) M8(Save, w7, w3, Wdata);

    Adder A1(32'd4, currentPC, w3);

    Adder A2(w3, {ExtendedImm[29:0], 2'b00}, w4);
    
    MUX #(32) M5(BranchJump, w3, w4, w5);
    MUX #(32) M6(Jump, w5, {currentPC[31:28], inst[25:0], 2'b00}, w6);
    MUX #(32) M7(Jumpr, w6, Rdata1, nextPC);

    assign OpCode = inst[31:26];
    assign Func = inst[5:0];
endmodule