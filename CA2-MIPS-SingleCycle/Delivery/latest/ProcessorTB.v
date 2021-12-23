`timescale 1ps/1ps
module ProcessorTB();
    
    wire [31:0] instructionMemAddress;
    wire [31:0] inst;
    wire [31:0] dataMemAddress;
    wire [31:0] inputDataMemData;
    wire [31:0] outputDataMem;
    wire MemRead, MemWrite;
    wire [31:0] maxValue;
    wire [31:0] maxIndex;
    reg clk = 1'b0, rst = 1'b1;

    InstMem IM (instructionMemAddress, inst);
    MIPS CPU(rst, clk, inst, inputDataMemData, instructionMemAddress, dataMemAddress, outputDataMem, MemRead, MemWrite);
    DataMem DM (dataMemAddress, outputDataMem, MemRead, MemWrite, clk, inputDataMemData, maxValue, maxIndex);
    
    always #5 clk = ~clk;
    initial
    begin
        #9 rst = 1'b0;
    	#2500 $stop;
    end
    
endmodule