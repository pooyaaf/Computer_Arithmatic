module Adder (a,
              b,
              cin,
	      out);
    input [31:0] a, b;
    input cin;
    //output co;
    output [31:0] out;
    
    assign out = a+b; //neew a 2's complement adder
    
endmodule
