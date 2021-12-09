`timescale 1ns/1ns
module Controller(
    input clk,
    rst,
    input [5:0] OpCode, 
    output reg RegDst,  
    RegWrite,
    AluSrc,
    MemRead,
    MemWrite,
    MemToReg,
    Jump,
    JalWrite,
    output reg [1:0] AluOp,
    Branch
);

parameter [5:0] 
    RT = 6'b000000, 
    addi = 6'b001000, 
    slti = 6'b001010, 
    beq = 6'b000100, 
    j = 6'b000010,
    jal = 6'b000011,
    lw = 6'b100011,
    sw = 6'b101011;

always @(OpCode, rst) begin
    {RegDst, RegWrite, AluSrc, MemRead, MemWrite, MemToReg, AluOp, Branch, Jump, JalWrite} = 12'd0;
    if(rst)
        {RegDst, RegWrite, AluSrc, MemRead, MemWrite, MemToReg, AluOp, Branch, Jump, JalWrite} = 12'd0;
    else begin
    case(OpCode)
        RT : begin
            RegDst = 1'b1;
            RegWrite = 1'b1;
            AluOp = 2'b11;
        end
        lw : begin
            RegWrite = 1'b1;
            AluSrc = 1'b1;
            MemRead = 1'b1;
            MemToReg = 1'b1;
        end
        sw : begin
            AluSrc = 1'b1;
            MemWrite = 1'b1;
        end
        beq : begin
            Branch = 2'b01;
            AluOp = 2'b01;
        end
      
        addi : begin
            RegWrite = 1'b1;
            AluSrc = 1'b1;
        end
        slti : begin
            RegWrite = 1'b1;
            AluSrc = 1'b1;
            AluOp = 2'b10;
        end
        j : begin
            Jump = 1'b1;
        end
        jal : begin
            RegWrite = 1'b1;
            Jump = 1'b1;
            JalWrite = 1'b1;
        end
    endcase
    end
end

endmodule