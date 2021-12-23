`timescale 1ps/1ps
module ALU (
    a,
    b,
    operation,
    ALUZeroFlag,
    aluOut
    );
    
    input [31:0] a, b;
    input [2:0] operation;
    
    output ALUZeroFlag;
    output reg [31:0] aluOut;
    
    wire [31:0] subtract;

    //operation states:
    parameter [2:0] 
        NOTHING = 3'b000,
        ADD = 3'b001,
        SUB = 3'b010,
        AND = 3'b011,
        OR  = 3'b100,
        SLT = 3'b101;//using sign

    assign subtract = a - b;

    always@(operation, a, b) begin
        case(operation) 
            ADD : aluOut = (a + b); //add
            SUB : aluOut = a - b; //sub
            AND : aluOut = a & b; //and
            OR  : aluOut = a | b; //or
            SLT : aluOut = ((subtract[31]) ? 32'd1: 32'd0); //branch(beq) and slt(i)
            default: aluOut = 32'd0;
        endcase           
    end
    
    assign ALUZeroFlag = (aluOut == 32'd0) ? 1'd1 : 1'd0;
    
endmodule
