`timescale 1ns/1ns
module JumpController(input [1:0] AluOp, input [5:0] Func, output Jumpr);
    assign Jumpr = ({AluOp, Func} == 8'b11011000) ? 1'b1 : 1'b0;

endmodule