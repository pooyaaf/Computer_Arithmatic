module mux3to1 #(parameter SIZE = 32) (i0, i1, i2, sel, out);
    input [SIZE-1:0] i0, i1, i2;
    input [1:0] sel;
    output [SIZE-1:0] out;
    
    assign out = (sel == 2'b00) ? i0:
    (sel == 2'b01) ? i1:
    i2;
    
endmodule
