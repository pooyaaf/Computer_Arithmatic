`timescale 1ps/1ps
module SignExti26 (
    inputData, 
    outputData
    );
    
    input [25:0] inputData;
    
    output [31:0] outputData;
    
    assign outputData = {{26{inputData[25]}}, inputData};
    
endmodule
