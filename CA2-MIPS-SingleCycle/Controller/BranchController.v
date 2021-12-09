`timescale 1ns/1ns
module BranchController(input Branch, input Zero, output BranchJump);
    assign BranchJump = (Branch == 1'b1 && Zero == 1'b1)  ? 1'b1 : 1'b0;
endmodule
