module mux2to1 #(parameter SIZE = 32) (i0, i1, sel, out);
    input [SIZE-1:0] i0, i1;
    input sel;
    output [SIZE-1:0] out;
    
    assign out = (sel == 1'b1) ? i1 : i0;
    
endmodule
