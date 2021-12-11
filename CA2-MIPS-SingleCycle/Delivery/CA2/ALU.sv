module ALU (a,
            b,
            operation,
            alu_out,
            zero);
    input [31:0] a, b;
    input [2:0] operation;
    output logic [31:0] alu_out;
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
            ADD : alu_out = (a + b); //add
            SUB : alu_out = a - b; //sub
            AND : alu_out = a & b; //and
            OR  : alu_out = a | b; //or
            SLT : alu_out = ((subtract[31]) ? 32'd1: 32'd0); //branch and slt(i)
            default: alu_out = 32'd0;
        endcase           
    end
    
    assign zero = (alu_out == 32'd0) ? 1'b1 : 1'b0;
    
endmodule
