`timescale 1ps/1ps
module ALUController (
    RTfunction,
    neededALUOperation,
    operation
    );
    
    input [5:0] RTfunction;
    input [1:0] neededALUOperation;
    output reg[2:0] operation;

    //RTfunctiontion states:
    parameter [5:0] 
        ADD_RTfunction = 6'b000001, //RType
        SUB_RTfunction = 6'b000010, //RType
        AND_RTfunction = 6'b000100, //RType
        OR_RTfunction  = 6'b001000, //RType
        SLT_RTfunction = 6'b010000; //RType

    //operation states:
    parameter [2:0] 
        NOTHING = 3'b000,
        ADD = 3'b001,
        SUB = 3'b010,
        AND = 3'b011,
        OR  = 3'b100,
        SLT = 3'b101;//using sign

    always @(neededALUOperation, RTfunction)
    begin
        operation = NOTHING;
        //J | JR | JAL | ADDI | LW | SW opcode is called and needs add operation 
        if (neededALUOperation == 2'b00)
            operation = ADD;
        //beEqual opcode is called and needs sub operation
        else if (neededALUOperation == 2'b01)
            operation = SUB;
        //SLTI opcode is called and needs sign operation
        else if (neededALUOperation == 2'b10)
            operation = SLT; 
        //NO opcode and time to check RTfunctiontions
        else if (neededALUOperation == 2'b11)
        begin
            case (RTfunction)
                ADD_RTfunction: operation = ADD; //add
                SUB_RTfunction: operation = SUB; //sub
                AND_RTfunction: operation = AND; //and
                OR_RTfunction : operation = OR ; //or
                SLT_RTfunction: operation = SLT; //slt
                default:  operation = NOTHING;
            endcase
        end 
    end
    
endmodule
