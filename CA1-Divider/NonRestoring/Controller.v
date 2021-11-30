`timescale 1 ns / 1 ns

module Controller(clk, rst, start, sign, validated, diviendLd, divisorLd, diviendLdSelect, sin, shl, addSub, ready, checker);

input clk;
input rst;
input start;
input sign;
input validated;
output reg ready, diviendLd, divisorLd, diviendLdSelect, sin, shl, addSub, checker;

parameter Start = 0;
parameter Load = 1;
parameter Sub = 2;
parameter Sign = 3;
parameter Add = 4;
parameter ShiftLeftZero = 5;
parameter ShiftLeftOne = 6;
parameter Check = 7;

reg enCount,loadCount;
reg[2:0] loadInit = 3; // n times count = 5
wire coutCount;

	reg[2:0] ps, ns = Start;
	Counter#(3) CCcounter(.clk(clk), .rst(rst), .en(enCount), .ld(loadCount), .initld(loadInit), .co(coutCount));
	always@(posedge clk,posedge rst)begin
		if(rst)
			ps <= Start;
		else
			ps <= ns;
	end

	always@(ps, start, coutCount, sign) begin
		case(ps)
			Start: ns = start ? Check : Start;
			Check: ns = validated ? Load : Start;
			Load: ns = Sub;
			Sub: ns = Sign;
			Sign: ns = sign ?  ( coutCount ? Add : ShiftLeftOne ) : ShiftLeftZero;
			Add: ns = coutCount ? Start : Sign;
			ShiftLeftZero : ns = coutCount ? Start : Sub;
			ShiftLeftOne : ns = Add;
		endcase
	end

	always @(ps) begin
		{diviendLd, diviendLdSelect, divisorLd, shl, addSub, ready, enCount,loadCount, sin, checker } = 0;
		case(ps)
			Start: begin ready = 1'b1; checker = 1'b1; end
			Check: checker = 1'b1;
			Load: begin diviendLd = 1'b1; divisorLd = 1'b1; diviendLdSelect = 1'b1; loadCount=1'b1; end
			Sub: begin addSub = 1'b1; diviendLdSelect = 1'b0; diviendLd = 1'b1; end
			Add: begin addSub = 1'b0; diviendLdSelect = 1'b0; diviendLd = 1'b1; end
			ShiftLeftZero: begin shl = 1'b1; enCount=1; sin = 1'b1; end
			ShiftLeftOne: begin shl = 1'b1; enCount=1; sin = 1'b0; end
		endcase
	end


endmodule
