`timescale 1ns/1ns
module AddSub (A, B, mode, SUM, cout);
parameter size = 5;
input [size-1:0] A, B;
input mode;
output [size-1:0] SUM;
output cout;

wire [size:0] carries;
genvar k;

generate
    for (k = 0; k < size; k = k + 1) begin
        wire  b;
        xor (b, mode, B[k]);
        FullAdder Adder(carries[k], A[k], b, SUM[k], carries[k + 1]);
    end
endgenerate
assign carries[0] = mode;
assign cout = carries[size];
endmodule