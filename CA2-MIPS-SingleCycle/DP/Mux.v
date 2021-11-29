`timescale 1ns/1ns
module MUX #(parameter N)(input sel, input [N - 1: 0] A, B, output [N - 1:0] res);
  assign res = (sel)? B : A;
endmodule

