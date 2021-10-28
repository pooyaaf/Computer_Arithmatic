`timescale 1ns/1ns
module FullAdder (a,b,cin,sum,co);
input a,b,cin;
output sum,co;
    wire p, g, cp;
    xor (p, a, b);
    xor (sum, p, cin);
    nand (g, a, b);
    nand (cp, p, cin);
    nand (co, g, cp);
endmodule
