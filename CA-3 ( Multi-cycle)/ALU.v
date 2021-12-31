`timescale 1ps/1ps
module ALU (
    a,
    b,
    operation,
    ALUZeroFlag,
    ALUNegFlag,
    ALUCarryFlag, 
    ALUOverflowFlag,
    aluOut
    );
    
    input [32:0] a, b;
    input [2:0] operation;
    
    output ALUZeroFlag;
    output ALUCarryFlag;
    output ALUOverflowFlag;
    output ALUNegFlag;
    output reg [32:0] aluOut;
    
    wire [32:0] subtract;

    //operation states:
    parameter [2:0] 
        //
        ADD =  3'b000,
        SUB = 3'b001,
        RSB = 3'b010,
        AND = 3'b011,
        NOT = 3'b100,
        TST = 3'b101,
        CMP = 3'b110,
        MOV = 3'b111;

    assign subtract = a - b;

    always@(operation, a, b) begin
        case(operation) 
            ADD : aluOut = (a + b); //add
            SUB : aluOut = a - b; //sub
            RSB : aluOut = a - b; //RSB
            AND : aluOut = a & b; //and
            NOT : aluOut = -b; // not
            //TST , CMP just set flag
            MOV : aluOut = b; //branch(beq) and slt(i)
            default: aluOut = 32'd0;
        endcase           
    end
    
    // finding zero flag in ALU
    assign ALUZeroFlag = (aluOut == 33'd0) ? 1'd1 : 1'd0;
    // finding negative flag in ALU
    assign ALUNegFlag = (aluOut < 0) ? 1'd1 : 1'd0;
    // finding overflow flag in ALU
    assign ALUOverflowFlag =( (aluOut[31]==1 && aluOut[30]==0 && aluOut[29]==0) || (aluOut[31]==0 && aluOut[30]==1 && aluOut[29]==1)) ? 1'd1 : 1'd0;
    // finding carry flag in ALU
    assign ALUCarryFlag = (aluOut[32] == 32'd1) ? 1'd1 : 1'd0;
    
endmodule
