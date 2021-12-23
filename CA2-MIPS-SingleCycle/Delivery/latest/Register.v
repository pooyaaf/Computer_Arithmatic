`timescale 1ps/1ps
module Register #(parameter SIZE = 32) (
    clk, 
    rst, 
    ld, 
    inputData, 
    outputData
    );
    
    input [SIZE-1:0] inputData;
    input rst, ld, clk;
    
    output reg[SIZE-1:0] outputData;
    
    always @(posedge clk)
    begin
        if (rst)
            outputData = 32'd0;
        else if (ld)
            outputData = inputData;
    end
        
endmodule
