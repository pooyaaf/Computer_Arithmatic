`timescale 1ns/1ns
module AddSubTest ();
    reg [4:0] A = 5'b01111, B = 5'b01011;
    reg mode = 1'b0;
    wire [4:0] sum;
    wire cout;
    AddSub #(6) UUT(.A(A), .B(B), .mode(mode), .SUM({cout,sum}));
    initial begin
        #500;
        mode = 1'b1;
        #500;
    end
endmodule