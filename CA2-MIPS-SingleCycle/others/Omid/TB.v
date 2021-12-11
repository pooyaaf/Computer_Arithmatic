`timescale 1ns/1ns
module TB;
    wire RegDst,
        RegWrite,
        AluSrc,
        MemRead,
        MemWrite,
        MemToReg,
        Jump,
        Jumpr,
        Save,
        BranchJump,
        Zero;
    wire [2:0] AluOperation;
    wire [5:0] OpCode, Func;
    reg clk = 1'b0, rst = 1'b1;

    MipsDatapath MD(
        .clk(clk),
        .rst(rst),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .AluSrc(AluSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .Jumpr(Jumpr),
        .Jump(Jump),
        .Save(Save),
        .BranchJump(BranchJump),
        .AluOperation(AluOperation),
        .OpCode(OpCode),
        .Func(Func),
        .Zero(Zero)
    );

    MipsController MC(
        .clk(clk),
        .rst(rst),
        .OpCode(OpCode),
        .Func(Func),
        .Zero(Zero),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .MemToReg(MemToReg),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .AluSrc(AluSrc),
        .Jump(Jump),
        .Jumpr(Jumpr),
        .Save(Save),
        .BranchJump(BranchJump),
        .AluOperation(AluOperation)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        #20 rst = 1'b0;
	//#660 $stop;
	#120 $stop;
    end

endmodule
