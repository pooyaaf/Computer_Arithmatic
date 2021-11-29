`timescale 1ns/1ns

module DataMemory(input memRead, memWrite, input [31:0] addr, writeData, output [31:0] readData);
  reg [31:0] Memory [0: 10000];
  initial begin
     $readmemh("data.mem", Memory);
  end
  assign readData = (memRead) ? Memory[addr[31:2]] : 32'bz;
  always@(addr, memWrite) begin
    if(memWrite)
      Memory[addr[31:2]] = writeData;
  end
endmodule
  
