`timescale 1ps/1ps
module Multiplexer3i1o #(parameter SIZE = 32) (
    i0, 
    i1, 
    i2, 
    selector, 
    out
    );
    
    input [SIZE-1:0] i0;
    input [SIZE-1:0] i1;
    input [SIZE-1:0] i2;
    input [1:0] selector;
    output [SIZE-1:0] out;
    
    assign out = (selector == 2'd0) ? i0 : (selector == 2'd1) ? i1 : i2;
    
endmodule
