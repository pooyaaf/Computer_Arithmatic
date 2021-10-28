`timescale 1ns/1ns
module DividerTB ();
    reg [9:0] Dividend;
    reg [4:0] Divider ;
    wire [4:0] Q, R;
    reg start = 1'b0, clk = 1'b0, rst = 1'b1;
    wire ready; 

    Divider UUT(clk, rst, start, Dividend, Divider, Q, R, ready);

    always #50 clk = ~clk;
    initial begin
	#0 Dividend = 10'b0000011010; Divider = 5'b00101;
        #200 rst = 1'b0;
        #200 start = 1'b1;
        #200 start = 1'b0;
        #3000
    #300 Dividend = 10'b0000010110; Divider = 5'b00011;
        #200 rst = 1'b0;
        #200 start = 1'b1;
        #200 start = 1'b0;
        #3000
     #300 Dividend = 10'b0000110110; Divider = 5'b00111;
        #200 rst = 1'b0;
        #200 start = 1'b1;
        #200 start = 1'b0;
        #3000
     #300 Dividend = 10'b0010010110; Divider = 5'b01111;
        #200 rst = 1'b0;
        #200 start = 1'b1;
        #200 start = 1'b0;
        #3000
     #300 Dividend = 10'b0011010110; Divider = 5'b01110;
        #200 rst = 1'b0;
        #200 start = 1'b1;
        #200 start = 1'b0;
        #3000
	#3000
	$stop;
    end
endmodule
