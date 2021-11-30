`timescale 1 ns / 1 ns
module CounterTB();
	reg clk,rst,ld,en;
	reg[3:0] initld;
	wire co;
	Counter#(4) cu(clk,rst,en,ld,initld,co);
	always #5 clk <= ~clk; 
	initial begin
		#0          clk=0;rst=1;
		#20         rst=0;en=1;
		#80 		initld= 5; ld = 1;
		#10 		ld=0;
		#1000		en=0;
		#50     	$stop;
	end
endmodule
