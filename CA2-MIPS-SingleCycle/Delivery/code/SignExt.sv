module SignExt (inputData, outputData);
    input [15:0] inputData;
    output [31:0] outputData;
    
    assign outputData = {{16{inputData[15]}}, inputData};
    
endmodule
