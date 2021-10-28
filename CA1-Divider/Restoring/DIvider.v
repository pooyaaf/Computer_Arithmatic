`timescale 1ns/1ns
module Divider (clk, rst, start, Dividend, Divisor, Q, R, ready);
    input clk, rst, start;
    input [9:0] Dividend;
    input [4:0] Divisor;
    output [4:0] Q, R;
    output ready;
    wire diviendLd, divisorLd, dividendSel, shl, sin, addSubSelect, sign;
    Controller controller(clk, rst,start, sign,  diviendLd, divisorLd, dividendSel, sin, shl, addSubSelect, ready);
    DataPath datapath(clk,rst,Dividend, Divisor, diviendLd, divisorLd, dividendSel, shl, sin, addSubSelect, sign, Q, R);
endmodule
