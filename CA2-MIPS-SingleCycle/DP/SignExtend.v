`timescale 1ns/1ns
module SignExtender(input [15:0] data, output [31:0] res);
    assign res = {{16{data[15]}}, data};
endmodule
