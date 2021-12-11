module SHL2 #(parameter SIZE = 32) (d_in, d_out);
    input [SIZE-1:0] d_in;
    output [SIZE-1:0] d_out;
    
    assign d_out = d_in << 2;
    
endmodule
