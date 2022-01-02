`timescale 1ns/1ns

module ALU (lop, rop, op, result, zero);
    input [1:0] op;
    input [31:0] lop, rop;
    output zero;
    output [31:0] result;

   parameter [2:0] 
        NOTHING = 3'b000,
        ADD = 3'b001,
        SUB = 3'b010,
        AND = 3'b011,
        OR  = 3'b100,
        SLT = 3'b101;//using sign

    assign result = op == ADD ? lop + rop :
                    op == SUB ? lop - rop :
                    op == SLT ? lop < rop ? 32'b1 : 32'b0 :
                    op == AND ? lop & rop :
                    op == OR ? lop | rop 
                    :32'b0;

    assign zero = result == 32'b0;
endmodule