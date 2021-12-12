module register #(parameter SIZE = 32) (inputData, rst, ld, clk, outputData);
    input [SIZE-1:0] inputData;
    input rst, ld, clk;
    output logic[SIZE-1:0] outputData;
    
    always @(posedge clk)
    begin
        if (rst)
            outputData = 'd0;
        else if (ld)
            outputData = inputData;
    end
        
endmodule
