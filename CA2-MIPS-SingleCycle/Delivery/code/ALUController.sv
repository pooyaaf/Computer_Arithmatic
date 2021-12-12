module ALUController (
    ALUOp,
    func,
    operation);
    input [1:0] ALUOp;
    input [5:0] func;
    output logic[2:0] operation;

    //function states:
    parameter [5:0] 
        ADD_FUNC = 6'b000001, //RType
        SUB_FUNC = 6'b000010, //RType
        AND_FUNC = 6'b000100, //RType
        OR_FUNC  = 6'b001000, //RType
        SLT_FUNC = 6'b010000; //RType

    //operation states:
    parameter [2:0] 
        NOTHING = 3'b000,
        ADD = 3'b001,
        SUB = 3'b010,
        AND = 3'b011,
        OR  = 3'b100,
        SLT = 3'b101;//using sign

    always @(ALUOp, func)
    begin
        operation = NOTHING;
        //LW or SW opcode is called and needs add operation 
        if (ALUOp == 2'b00)
            operation = ADD;
        //BEQ opcode is called and needs sub operation
        else if (ALUOp == 2'b01)
            operation = SUB;
        //SLTI opcode is called and needs sign operation
        else if (ALUOp == 2'b10)
            operation = SLT; 
        //NO opcode and time to check function
        else if (ALUOp == 2'b11)
        begin
            case (func)
                ADD_FUNC: operation = ADD; //add
                SUB_FUNC: operation = SUB; //sub
                AND_FUNC: operation = AND; //and
                OR_FUNC : operation = OR ; //or
                SLT_FUNC: operation = SLT; //slt
                default:  operation = NOTHING;
            endcase
        end 
    end
    
endmodule
