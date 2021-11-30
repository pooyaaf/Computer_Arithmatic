`timescale 1 ns / 1 ns
module Counter(clk, rst, en, ld, initld, co);
parameter n = 3;
input clk,rst,en,ld;
input [n-1:0] initld;
output co;
	reg [n-1:0]PO;
	always@(posedge clk,posedge rst)begin
		if(rst)
			PO <= 3'd0;
		else begin
			if(ld)
				PO <= initld;
			else
				if(en)
					PO <= en ? PO+1 : PO;
		end
	end
	assign co = en ? &PO : 1'b0;
endmodule
