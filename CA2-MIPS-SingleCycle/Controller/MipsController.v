`timescale 1ns/1ns
module MipsController(
    input [5:0] OpCode,
    Func,
    input Zero,
    clk,
    rst,
    output RegDst,
    RegWrite,
    AluSrc,
    MemRead,
    MemWrite,
    MemToReg,
    Jump,
    Jumpr,
    JalWrite,
    BranchJump,
    output [2:0] AluOperation 
);
    wire [1:0] AluOp, Branch;

    Controller C(
        .clk(clk),
        .rst(rst),
        .OpCode(OpCode),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .AluSrc(AluSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .AluOp(AluOp),
        .Branch(Branch),
        .Jump(Jump),
        .JalWrite(JalWrite)
    );

    AluController AC(
        .AluOp(AluOp),
        .AluOperation(AluOperation),
        .Func(Func)
    );

    JumpController JC(
        .AluOp(AluOp),
        .Func(Func),
        .Jumpr(Jumpr)
    );

    BranchController BC(
        .Branch(Branch),
        .Zero(Zero),
        .BranchJump(BranchJump)
    );
endmodule
