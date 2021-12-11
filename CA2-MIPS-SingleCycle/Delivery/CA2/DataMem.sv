`timescale 1ns/1ns
//fix the size
module DataMem (
    adr,
    d_in,
    MemRead,
    MemWrite,
    clk,
    d_out,
    maxValue,
    maxIndex);
    input [31:0] adr;
    input [31:0] d_in;
    input MemRead, MemWrite, clk;
    output [31:0] d_out;
    
    logic [31:0] mem[0:65535];
    output [31:0] maxValue;
    output [31:0] maxIndex;
    
    initial
    begin
        $readmemb("DataMemory.txt", mem, 250);
    end
    
    always @(posedge clk) // Write on memory
        if (MemWrite == 1'b1) begin
            mem[adr[31:2]] = d_in;
        end
    
    assign d_out = (MemRead == 1'b1) ? mem[adr[31:2]] : 32'd0;
    assign maxValue = mem[500];//2000/4=500
    assign maxIndex = mem[501];//2004/4=501
    
endmodule
