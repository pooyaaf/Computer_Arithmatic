module ALU (
    a,
    b,
    operation,
    aluOut,
    zero);
    input [31:0] a, b;
    input [2:0] operation;
    output logic [31:0] aluOut;
    output zero;
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
            SLT : aluOut = ((subtract[31]) ? 32'd1: 32'd0); //branch and slt(i)
            default: aluOut = 32'd0;
        endcase           
    end
    
    assign zero = (aluOut == 32'd0) ? 1'b1 : 1'b0;
    
endmodule
