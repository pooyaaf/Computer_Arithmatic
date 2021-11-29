`timescale 1ns/1ns

module RegisterFile ( clk, rst, raddr1, raddr2, waddr, write, writeData, readData1, readData2);
input clk , rst , write;
input [4:0] raddr1,raddr2,waddr;
input [31:0] writeData;
output [31:0] readData1,readData2;
reg [31:0]File[31:0];

assign File [0] = 32'b0;
assign readData1 = File[raddr1];
assign readData2 = File[raddr2];

always @(posedge clk) begin
    if(rst)
        File [0] = 32'b0;
    else if(write)
        File[waddr] <= writeData;
end
endmodule