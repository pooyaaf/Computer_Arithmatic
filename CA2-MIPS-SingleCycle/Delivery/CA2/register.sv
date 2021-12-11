module register #(parameter SIZE = 32) (d_in, rst, ld, clk, d_out);
    input [SIZE-1:0] d_in;
    input rst, ld, clk;
    output logic[SIZE-1:0] d_out;
    
    always @(posedge clk)
    begin
        if (rst)
            d_out = 'd0;
        else if (ld)
            d_out = d_in;
    end
        
endmodule
