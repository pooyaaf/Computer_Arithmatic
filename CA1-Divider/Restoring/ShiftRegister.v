`timescale 1 ns / 1 ns
module ShiftRegister (PI, clk, rst, sin, ld, shl, PO);
parameter n=5;
input clk, rst, sin, ld, shl;
input[n-1:0] PI;
output reg[n-1:0] PO;

	always@(posedge clk, posedge rst)begin
		if(rst)
			PO <= 0;
		else if (ld) 
			PO <= PI;
		else if (shl) 
			PO <= {PO[n-2:0], sin};
	end
endmodule
			
