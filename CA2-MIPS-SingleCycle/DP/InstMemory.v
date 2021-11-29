`timescale 1ns/1ns

module InstMemory(input [31:0] addr, output [31:0] instruction);
  reg [31:0] InstMem [0:1000];
  initial begin
    $readmemb("Insts.mem", InstMem);
  end
  assign instruction = InstMem[addr[31:2]];
endmodule

