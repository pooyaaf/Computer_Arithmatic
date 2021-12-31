`timescale 1ps/1ps
module SignExti12 (
    inputData, 
    outputData
    );
    
    input [11:0] inputData;
    
    output [31:0] outputData;
    
    assign outputData = {{12{inputData[11]}}, inputData};
    
endmodule
