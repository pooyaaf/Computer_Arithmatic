`timescale 1ps/1ps
module Controller (
    opcode,//from instruction memry in TB
    RTfunction,//from instruction memry in TB
    ALUZeroFlag,//from datapath
    RegDst,//to datapath
    DataWrite,//to datapath
    RegWrite,//to datapath
    operation,//to datapath
    ALUsrc,//to datapath
    MemtoReg,//to datapath
    MemWrite,//to TB then datamemory
    MemRead,//to TB then datamemory
    PCSrc,//to datapath
    jump,//to datapath
    jr//to datapath
    );
    
    input [5:0] opcode;
    input [5:0] RTfunction;
    input ALUZeroFlag;

    output reg [1:0] RegDst;//MIPS signals
    output reg [1:0] DataWrite;//our signals
    output reg RegWrite;//MIPS signals
    output [2:0] operation;//MIPS signals
    output reg ALUsrc;//MIPS signals
    output reg MemtoReg;//MIPS signals
    output reg MemWrite;//MIPS signals
    output reg MemRead;//MIPS signals
    output PCSrc;//MIPS signals
    output reg jump;//our signals
    output reg jr;//our signals
    
    reg [1:0] neededALUOperation;//comes from opcodes
    reg beEqual;//branch equal
    
    parameter [5:0] 
        RT_OPC = 6'b000000, //RType opcode
        ADDI_OPC = 6'b000001, //IType
        SLTI_OPC = 6'b000010, //IType
        LW_OPC = 6'b000011, //IType(mem ref)
	    SW_OPC = 6'b000100, //IType(mem ref)
        beEqual_OPC = 6'b000101, //IType(control flow)
        J_OPC = 6'b000110, //JType
	    JR_OPC = 6'b000111, //RType
        JAL_OPC = 6'b001000; //JType

    ALUController ALU_CTRL(.RTfunction(RTfunction), .neededALUOperation(neededALUOperation), .operation(operation));
    
    always @(opcode, operation)
    begin
        {RegDst, ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, beEqual, neededALUOperation, jump, jr, DataWrite} = 15'd0;
        case (opcode)
            //RType instructions //add,sub,and,or,slt
            RT_OPC:
            begin
                neededALUOperation = 2'd3;
                RegWrite = 1'd1;
                RegDst = 2'd1;
            end

            //IType Add immediate (addi) instruction
            ADDI_OPC:
            begin
                RegWrite = 1'd1;
                ALUsrc = 1'd1;
            end

            //IType Set Less Than immediate (SLTi) instruction
            SLTI_OPC:
            begin
                neededALUOperation = 2'd2;
                DataWrite = 2'd2;
                RegWrite = 1'd1;
                ALUsrc = 1'd1;
            end

            //IType(mem ref) Load Word (lw) instruction //using initial state for neededALUOperation which is neededALUOperation=2'b00
            LW_OPC:
            begin
                MemRead = 1'd1;
                MemtoReg = 1'd1;
                RegWrite = 1'd1;
                ALUsrc = 1'd1;
            end

            //IType(mem ref) Store Word (sw) instruction //using initial state for neededALUOperation which is neededALUOperation=2'b00
            SW_OPC:
            begin
                MemWrite = 1'd1;
                ALUsrc = 1'd1;                
            end

            //IType(control flow) Branch on equal (beEqual) instruction
            beEqual_OPC:
            begin
                neededALUOperation = 2'd1;
                beEqual = 1'd1;
            end

            //JType Jump (j) instruction
            J_OPC:
            begin
                jump = 1'd1;
            end
            
            //RType Jump (j) instruction
            JR_OPC:
            begin
                jump = 1'd1;
                jr = 1'd1;
            end

            ///JType Jump and link (jal) instruction
            JAL_OPC:
            begin
                jump = 1'd1;
                DataWrite = 2'd1;
                RegWrite = 1'd1;
                RegDst = 2'd2;
            end
        //NOP
	    default: ;//wait
        endcase
    end
    
    //EqualJumper ej(.ALUZeroFlag(ALUZeroFlag), .beEqual(beEqual), .PCSrc(PCSrc));

endmodule