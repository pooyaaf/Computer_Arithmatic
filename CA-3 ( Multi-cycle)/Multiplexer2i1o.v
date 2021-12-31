
`timescale 1ps/1ps
module Multiplexer2i1o #(parameter SIZE = 32) (
    i0, 
    i1, 
    selector, 
    out
    );
    
    input [SIZE-1:0] i0;
    input [SIZE-1:0] i1;
    input selector;
    
    output [SIZE-1:0] out;
    
    assign out = (selector == 1'd1) ? i1 : i0;
    
endmodule
