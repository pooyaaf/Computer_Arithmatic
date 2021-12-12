module SHL2 #(parameter SIZE = 32) (inputData, outputData);
    input [SIZE-1:0] inputData;
    output [SIZE-1:0] outputData;
    
    assign outputData = inputData << 2;
    
endmodule
