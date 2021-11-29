`timescale 1ns/1ns
module ALU (input [31:0] A, B, input [2:0] op, output zero, output [31:0] result);

    parameter Add = 3'b000, Sub = 3'b001, And = 3'b010 , Or = 3'b011 , Slt = 3'b100;
    assign result = op == Add ? A + B :
                    op == Sub ? A - B :
                    op == And ? A & B : 
                    op == Or  ? A | B :
                    op == Slt ? A < B  ? 32'b1 : 32'b0
                    :32'b0;


    assign zero = result == 32'b0;
endmodule
