`timescale 1ps/1ps
module EqualJumper(
    ALUZeroFlag,
    beEqual,
    PCSrc
    );
    
    input ALUZeroFlag;
    input beEqual;
    
    output PCSrc;
    
    assign PCSrc = beEqual ? (ALUZeroFlag) : 1'b0; //1'b0 acts like branch for beEqual.
   
endmodule
