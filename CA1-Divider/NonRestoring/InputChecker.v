`timescale 1ns/1ns
module InputChecker (clk, rst, Dividend, Divisor, checker, validated, OV, DivByZero);
    parameter n = 10;
    parameter m = 5;
    input [n-1:0] Dividend;
    input [m-1:0] Divisor;
    input clk, rst, checker;
    output OV, DivByZero;
    output validated;

    wire[m:0] result;

    AddSub #(6) ALUChecker({1'b0,Divisor},{1'b0,Dividend[9:5]},checker,result);

    assign validated = (|Divisor) & ~result[m];
    assign OV = result[m];
    assign DivByZero = ~(|Divisor);

endmodule 