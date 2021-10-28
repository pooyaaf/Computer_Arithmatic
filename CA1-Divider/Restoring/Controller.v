`timescale 1 ns / 1 ns

module Controller(clk, rst,start, sign,  diviendLd, divisorLd, diviendLdSelect, sin, shl, addSub, ready);

input clk;
input rst;
input start;
input sign;
output reg ready, diviendLd, divisorLd, diviendLdSelect, sin, shl, addSub;

parameter Start = 0;
parameter Load = 1;
parameter Sub = 2;
parameter Add = 3;
parameter ShiftLeftZero = 4;
parameter ShiftLeftOne = 5;
parameter Restore = 6;

reg enCount,loadCount;
reg[2:0] loadInit = 3; // n times count = 5
wire coutCount;


	reg[2:0] ps, ns = Start;
	Counter#(3) CCcounter(clk,rst,enCount,loadCount,loadInit,coutCount);
	always@(posedge clk,posedge rst)begin
		if(rst)
			ps <= Start;
		else
			ps <= ns;
	end

	always@(ps, start, coutCount, sign) begin
		case(ps)
			Start: ns = start ? Load : Start;
			Load: ns = Sub;
			Sub: ns = Restore;
			Restore : ns = sign ? Add : ShiftLeftOne;
			Add: ns = ShiftLeftZero;
			ShiftLeftZero : ns = coutCount ? Start : Sub;
			ShiftLeftOne : ns = coutCount ? Start : Sub;
		endcase
	end

	always @(ps) begin
		{diviendLd, diviendLdSelect, divisorLd, shl, addSub, ready, enCount,loadCount, sin} = 0;
		case(ps)
			Start : ready = 1'b1;
			Load: begin diviendLd = 1'b1; divisorLd = 1'b1; diviendLdSelect = 1'b1; loadCount=1'b1; end
			Sub: begin addSub = 1'b1; diviendLdSelect = 1'b0; diviendLd = 1'b1; end
			Add: begin addSub = 1'b0; diviendLdSelect = 1'b0; diviendLd = 1'b1; end
			ShiftLeftZero: begin shl = 1'b1; enCount=1; sin = 1'b0; end
			ShiftLeftOne: begin shl = 1'b1; enCount=1; sin = 1'b1; end
		endcase
	end
endmodule


