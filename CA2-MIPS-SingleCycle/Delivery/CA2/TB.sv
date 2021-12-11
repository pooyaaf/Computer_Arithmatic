`timescale 1ns/1ns
module TB();
    wire [31:0] inst_adr, inst, data_adr, data_in, data_out;
    wire MemRead, MemWrite;
    logic clk = 1'b0, rst;
    wire [31:0] maxValue;
    wire [31:0] maxIndex;

    InstMem IM (inst_adr, inst);
    MIPS CPU(rst, clk, inst, data_in, inst_adr, data_adr, data_out, MemRead, MemWrite);
    DataMem DM (data_adr, data_out, MemRead, MemWrite, clk, data_in, maxValue, maxIndex);
    
    always #8 clk = ~clk;
    initial
    begin
        rst     = 1'b1;
        #15 rst = 1'b0;
    	#2500 $stop;
    end
    
endmodule