`timescale 1 ns / 1 ns
module ShiftRegTB();
	reg clk,rst,sin, ld, shl;
	reg[4:0] PI;
	reg[9:0] PI2;
	wire[4:0] PO;
	wire[9:0] PO2;
	ShiftRegister #(5) regOne(PI,clk,rst,sin,ld, shl,PO);
	ShiftRegister #(10) regTwo(PI2,clk,rst,sin,ld, shl,PO2);
	always #20 clk <= ~clk; 
	initial begin
		#0
		clk=0;sin=0;rst=0;ld=0;shl=0;
		#600
		PI = 5;
		PI2 = 17;
		ld = 1;
		#100
		ld = 0;
		shl = 1;
		#200
		shl= 0;
		#140
	    $stop;
	end
endmodule
