`timescale 1ps/1ps
module Adder(
  a, 
  b,
  result
  );

  input [31:0] a; 
  input [31:0] b; 
  
  output [31:0] result;

  assign result = a + b;

endmodule
