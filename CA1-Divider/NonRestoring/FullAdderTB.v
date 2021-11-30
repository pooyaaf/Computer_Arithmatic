`timescale 1ns/1ns
 module FullAdderTB ();
     reg a, b, cin;
     wire sum, cout;
     FullAdder UUT(a,b,cin,sum,cout);

     initial begin
         #300
         a = 1'b1; b= 1'b0; cin = 1'b0;
         #300
         a = 1'b0; b= 1'b0; cin = 1'b1;
         #300
         a = 1'b1; b= 1'b1; cin = 1'b1;
         #300 $stop;
     end
 endmodule
