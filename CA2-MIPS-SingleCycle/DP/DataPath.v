`timescale 1ns/1ns
module DataPath(
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
    JalWrite,
    Branch,
    input [2:0] AluOperation,
    output [5:0] OpCode,Func,
    output Zero
);

 
    wire [31:0]    w3, w4, w5, w6, w7;
    //pc
    wire [31:0] pcCurrAddr;
    wire [31:0] pcNextAddr;
    PC P(clk, rst, pcNextAddr, pcCurrAddr);
    //Inst Mem
    wire [31:0] instruction;
    InstMemory IM(pcCurrAddr, instruction);
    
    assign OpCode = instruction[31:26];
    assign Func = instruction[5:0];
    
    //Register File
    wire [4:0] Wreg;
    wire [31:0]  Wdata, Rdata1, Rdata2;
        //regDst : 
        wire [4:0] w1;
        MUX #(5) M1(RegDst, instruction[20:16], instruction[15:11], w1);
        MUX #(5) M2(JalWrite, w1, 5'd31, Wreg) ;
        
    RegisterFile RF(clk, rst,  instruction[25:21],instruction[20:16],Wreg,RegWrite, Wdata, Rdata1, Rdata2);
    //ALU
        //Sign Extend
        wire [31:0] extended;
        SignExtend signExtend(instruction[15:0], extended);
        //
        wire [31:0] Operand2;
        MUX #(32) M3(AluSrc, Rdata2, extended, Operand2);
    wire [31:0]  AluResult;
    ALU A(Rdata1, Operand2, AluOperation, Zero, AluResult);
    //Memory (RAM etc.)
     wire [31:0]   dataMemRes;
    DataMemory DM(MemRead, MemWrite, AluResult, Rdata2, dataMemRes);
    MUX #(32) M4(MemToReg, AluResult, dataMemRes, w7);
    // RF - > write path :
    MUX #(32) M8(JalWrite, w7, w3, Wdata);
    //Next pc Path

    Adder A1(32'd4, pcCurrAddr, w3);

    Adder A2(w3, {extended[29:0], 2'b00}, w4);
    
    MUX #(32) M5(Branch, w3, w4, w5);
    MUX #(32) M6(Jump, w5, {pcCurrAddr[31:28], instruction[25:0], 2'b00}, w6);
    MUX #(32) M7(Jumpr, w6, Rdata1, pcNextAddr);

endmodule