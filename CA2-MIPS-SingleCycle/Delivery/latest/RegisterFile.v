`timescale 1ps/1ps
module RegisterFile (
    clk,
    rst,
    RegWrite,
    ReadRegister1,
    ReadRegister2,
    WriteRegister,
	WriteData,
    ReadData1,
    ReadData2
	);

    input clk;
    input rst;
    input RegWrite;
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
    input [31:0] WriteData;
    
	output [31:0] ReadData1, ReadData2;
    
    parameter EXT0 = 32'd0;
    parameter R0 = 5'd0;

	reg [31:0] register_file [0:31];
    integer i;  
    always @(posedge clk) begin: load_data
    	if (rst)
	        for (i = 0; i < 32 ; i = i+1)
            	register_file[i] <= EXT0;
            else if (RegWrite)
            	if (WriteRegister != R0)
        			register_file[WriteRegister] <= WriteData;
	end

    assign ReadData1 = (ReadRegister1 == R0) ? EXT0 : register_file[ReadRegister1];
	assign ReadData2 = (ReadRegister2 == R0) ? EXT0 : register_file[ReadRegister2];
    
endmodule
