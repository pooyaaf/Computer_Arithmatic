`timescale 1ns/1ns
//fix the size
module DataMem (
    adr,
    inputData,
    MemRead,
    MemWrite,
    clk,
    outputData,
    maxValue,
    maxIndex);
    input [31:0] adr;
    input [31:0] inputData;
    input MemRead, MemWrite, clk;
    output [31:0] outputData;
    
    logic [31:0] mem[0:65535];
    output [31:0] maxValue;
    output [31:0] maxIndex;
    
    initial
    begin
        $readmemb("DataMemory.txt", mem, 250);
    end
    
    always @(posedge clk) // Write on memory
        if (MemWrite == 1'b1) begin
            mem[adr[31:2]] = inputData;
        end
    
    assign outputData = (MemRead == 1'b1) ? mem[adr[31:2]] : 32'd0;
    assign maxValue = mem[500];//2000/4=500
    assign maxIndex = mem[501];//2004/4=501
    
endmodule
