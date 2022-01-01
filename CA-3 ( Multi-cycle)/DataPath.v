`timescale 1ns/1ns

module DataPath (clk,pcWrite,IorD,MemWrite,MemRead,IRWrite,DPI,
                BLink,DTI,WriteReg,ALUASel,ALUBSel,ALUop,ld,en,PCSrc,
                ZEro,carry,negative,overflow,
                opCode, func
 );
    input clk;
    input pcWrite,IorD,MemWrite,MemRead,IRWrite,DPI,BLink;
    input [1:0] DTI;
    input WriteReg,ALUASel;
    input [1:0] ALUBSel;
    input [1:0] ALUop;
    input ld,en,PCSrc;
    output ZEro,carry,negative,overflow;
    output [5:0] opCode, func;
//PC
      wire [31:0] pcCurrAddr;
      wire [31:0] pcNextAddr;
    // pc src mux wires at the bottom
      programCounter pc(clk, pcNextAddr, pcCurrAddr);
  
//Inst Mem
    wire [31:0] instruction; // 32 bit wire comming out of Instruction Mem
    MemoryBlock instMem(clk, pcCurrAddr,1'b0,,instruction); // mem without write data + signal write zero
    // IR and MDR
    wire [31:0] IRout,MDRout;
    EnRegister IR1(clk,instruction,IRout,IRWrite);
    Register MDR1(clk,instruction,IRout);
//Register File
    wire [31:0] readRegInput2,writeRegInp;
    Multiplexer2i1o RFreadreg1(IRout[3:0],IRout[15:12],DPI,readRegInput2);
    Multiplexer2i1o RFwritereg1(IRout[15:12],4'b1111,BLink,writeRegInp);
    Multiplexer3i1o RFwritedata1(MDRout,currAddr,pcNextAddr,DTI);
    wire [31:0] writeData,readData1,readData2;
    RegisterFile registerFile(clk,1'b0,WriteReg,IRout[19:16],
    readRegInput2,writeRegInp,writeData,readData1,readData2
     );
//ُSign Ext
    wire [31:0] immediate1,immediate2;
    SignExti12 signExtend1(IRout[11:0], immediate1);
    SignExti26 signExtend2(IRout[25:0], immediate2);
//ALU
    wire [31:0] ARegout;
    Register A(clk,readData1,ARegout);
    wire [31:0] AMuxin;
    Multiplexer2i1o A1(pcCurrAddr,ARegout,ALUASel,AMuxin);
    //
    wire [31:0] BRegout;
    Register B(clk,readData2,BRegout);
    wire [31:0] BMuxin;
    Multiplexer4i1o B1(BRegout,32'b1,immediate1,immediate2,ALUBSel,BMuxin);
    //
    wire [31:0] ALUResult;//res ALU
    wire zero1,carry1,negative1,overflow1;
    ALU alu(AMuxin,BMuxin,ALuop,zero1,carry1,negative1,overflow1,ALUResult);
//Flag set
    EnRegister ze_ro(clk,zero1,ZEro,ld);
    EnRegister en_gea_tive(clk,negative1,negative,ld);
    EnRegister carr_y(clk,carry1,carry,en);
    EnRegister over_flow(clk,overflow1,overflow,en);
//ALU out and pc src
    wire [31:0] alu_out;
    Register alu_out1(clk,ALUResult,alu_out);
    //pc src
    Multiplexer2i1o pcSrc1(ALUResult,alu_out,PCSrc,pcNextAddr);
//Setting Controller UP
    // function ?!!!! 
    assign opCode = IRout[22:20];
endmodule
