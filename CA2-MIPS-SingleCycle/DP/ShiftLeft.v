`timescale 1ns/1ns

module ShiftLeft (data, shifted);

parameter size = 32;
parameter shcount = 2;

input [size-1:0] data;
output [size-1:0] shifted;

assign shifted = data << shcount;

endmodule
