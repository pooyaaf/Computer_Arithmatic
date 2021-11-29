`timescale 1ns/1ns

module PC(input clk, rst, input [31:0] nextPC, output reg [31:0] currentPC);
  always@(posedge clk, posedge rst) begin
    if(rst)
      currentPC <= 32'd0;
    else
      currentPC <= nextPC;
  end
endmodule

    

