module RegisterFile (
	WriteData,
    ReadRegister1,
    ReadRegister2,
    WriteRegister,
    RegWrite,
    rst,
    clk,
    ReadData1,
    ReadData2);

    	input [31:0] WriteData;
    	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
    	input RegWrite, rst, clk;
    	output [31:0] ReadData1, ReadData2;
    
    	logic [31:0] register_file [0:31];
    	integer i;  
    	always @(posedge clk) begin: load_data
        	if (rst)
	            	for (i = 0; i < 32 ; i = i+1)
                			register_file[i] <= 32'd0;
                	else if (RegWrite)
                		if (WriteRegister != 5'd0)
                    			register_file[WriteRegister] <= WriteData;
	end

    	assign ReadData1 = (ReadRegister1 == 5'b0) ? 32'd0 : register_file[ReadRegister1];
    	assign ReadData2 = (ReadRegister2 == 5'b0) ? 32'd0 : register_file[ReadRegister2];
    
endmodule
