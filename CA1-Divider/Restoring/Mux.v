`timescale 1ns/1ns
module Mux (A, B, sel, Data);
    parameter size = 10;
    input [size-1:0] A, B;
    input sel;
    output [size-1:0] Data;
    assign Data = sel ? A : B;

endmodule