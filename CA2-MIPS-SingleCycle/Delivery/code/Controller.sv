module Controller (
    opcode,
    func,
    zero,
    RegDst,
    MemtoReg,
    RegWrite,
    ALUsrc,
    MemRead,
    MemWrite,
    PCSrc,
    operation,
    dataToWrite,
    jr,
    jmp);
    
    input [5:0] opcode;
    input [5:0] func;
    input zero;
    output  PCSrc;
    output logic MemtoReg, RegWrite, ALUsrc, MemRead, MemWrite;
    output [2:0] operation;
    output logic [1:0] RegDst, dataToWrite;//our signals
    output logic jr, jmp;//our signals
    
    logic [1:0] ALUOp;
    logic beq;
    
    parameter [5:0] 
        RT_OPC = 6'b000000, //RType opcode
        ADDI_OPC = 6'b000001, //IType
        SLTI_OPC = 6'b000010, //IType
        LW_OPC = 6'b000011, //IType(mem ref)
	    SW_OPC = 6'b000100, //IType(mem ref)
        BEQ_OPC = 6'b000101, //IType(control flow)
        J_OPC = 6'b000110, //JType
	    JR_OPC = 6'b000111, //RType
        JAL_OPC = 6'b001000; //JType

    ALUController ALU_CTRL(ALUOp, func, operation);
    
    always @(opcode, operation)
    begin
        {RegDst, ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, beq, ALUOp, jmp, jr, dataToWrite} = 15'd0;
        case (opcode)
            //RType instructions //add,sub,and,or,slt
            RT_OPC: {RegDst, RegWrite, ALUOp} = {2'b01, 1'b1, 2'b11};

            //IType Add immediate (addi) instruction
            ADDI_OPC: {RegWrite, ALUsrc} = 2'b11;

            //IType Set Less Than immediate (SLTi) instruction
            SLTI_OPC: {RegWrite, ALUsrc, ALUOp, dataToWrite} = {1'b1, 1'b1, 2'b10, 2'b10};
            
            //IType(mem ref) Load Word (lw) instruction //using initial state for ALUOp which is ALUOp=2'b00
            LW_OPC: {ALUsrc, MemtoReg, RegWrite, MemRead} = 4'b1111;
            
            //IType(mem ref) Store Word (sw) instruction //using initial state for ALUOp which is ALUOp=2'b00
            SW_OPC: {ALUsrc, MemWrite} = 2'b11;

            //IType(control flow) Branch on equal (beq) instruction
            BEQ_OPC: {beq, ALUOp} = {1'b1, 2'b01};

            //JType Jump (j) instruction
            J_OPC: {jmp} = 1'b1;
            
            //RType Jump (j) instruction
            JR_OPC: {jr, jmp} = {2'b11};

            ///JType Jump and link (jal) instruction
            JAL_OPC: {RegWrite, RegDst, dataToWrite, jmp} = {1'b1, 2'b10, 2'b01, 1'b1};

        endcase
    end
    
    assign PCSrc = beq ? (zero) : 1'b0;
    
endmodule
