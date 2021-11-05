`timescale 1ns/1ns
module Divider (clk, rst, start, Dividend, Divisor, Q, R, ready, OV, DivByZero);
    input clk, rst, start;
    input [9:0] Dividend;
    input [4:0] Divisor;
    output [4:0] Q, R;
    output ready, OV, DivByZero;
    wire validated, diviendLd, divisorLd, dividendSel, shl, sin, addSubSelect, sign;
    Controller controller(.clk(clk), .rst(rst), .start(start), .sign(sign), .validated(validated), .diviendLd(diviendLd), .divisorLd(divisorLd), .diviendLdSelect(dividendSel), .sin(sin), .shl(shl), .addSub(addSubSelect), .ready(ready), .checker(checker));
    DataPath datapath(.clk(clk), .rst(rst), .Dividend(Dividend), .Divisor(Divisor), .diviendLd(diviendLd), .divisorLd(divisorLd), .dividendSel(dividendSel), .shl(shl), .sin(sin), .addSubSelect(addSubSelect), .checker(checker), .sign(sign), .validated(validated), .Q(Q), .R(R), .OV(OV), .DivByZero(DivByZero));
endmodule
