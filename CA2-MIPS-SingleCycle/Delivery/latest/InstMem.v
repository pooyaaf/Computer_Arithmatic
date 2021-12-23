`timescale 1ps/1ps
module InstMem (
    adr, 
    out
    );
    
    input [31:0] adr;
    
    output [31:0] out;
// instruction memory
//algo: first num is max, then for each num we subtract max and num, if it was  

//Arithmetic 
// ADD: Rd,Rs,Rt : Rd<-Rs+Rt : RT = {OPC[31-26],Rs[25-21],Rt[20-16],Rd[15-11],shamnt[10,6],RTfunction[5,0]}
// ADDI: Rt,Rs,I : Rt<-Rs+I : I = {OPC[31-26],Rs[25-21],Rt[20-16],immediate[15,0]}
// SUB: Rd,Rs,Rt : Rd<-Rs-Rt : RT = {OPC[31-26],Rs[25-21],Rt[20-16],Rd[15-11],shamnt[10,6],RTfunction[5,0]}
// SLT: Rd,Rs,Rt : Rs<Rt ? Rd<-1 : Rd<-0; : RT = {OPC[31-26],Rs[25-21],Rt[20-16],Rd[15-11],shamnt[10,6],RTfunction[5,0]}
// SLTI: Rt,Rs,I : Rs<I ? Rt<-1 : Rt<-0; : I = {OPC[31-26],Rs[25-21],Rt[20-16],immediate[15,0]}
// AND: Rd,Rs,Rt : Rd<-Rs&Rt : RT = {OPC[31-26],Rs[25-21],Rt[20-16],Rd[15-11],shamnt[10,6],RTfunction[5,0]}
// OR: Rd,Rs,Rt : Rd<-Rs|Rt : RT = {OPC[31-26],Rs[25-21],Rt[20-16],Rd[15-11],shamnt[10,6],RTfunction[5,0]}
//Mem Reference
// LW: Rt,I(Rs) : Rt<-RAM[Rs+I] : I = {OPC[31-26],Rs[25-21],Rt[20-16],immediate[15,0]}
// SW: Rt,I(Rs) : RAM[Rs+I]<-Rt : I = {OPC[31-26],Rs[25-21],Rt[20-16],immediate[15,0]}
//Control Flow
// J: Addr : PC<-PC+{PC[31,28],Addr<<2} : J = {OPC[31,26],Addr[25,0]}
// JR: Rs : PC<-Rs : RT = {OPC[31,26],Rs[25,21]}
// JAL: Addr : R31<-PC+4 PC<-PC+{PC[31,28],Addr<<2} : J = {OPC[31,26],Addr[25,0]}
// beEqual: Rs,Rt,I : Rs==Rt ? PC<-PC+4+I<<2 : PC<-PC+4; : I = {OPC[31-26],Rs[25-21],Rt[20-16],immediate[15,0]}

    reg [31:0] mem[0:65535];

    initial
    begin
        $readmemb("InstructionMemory.txt", mem);
    end
    
    assign out = mem[adr[31:2]];//{mem[adr[15:0]+3], mem[adr[15:0]+2], mem[adr[15:0]+1], mem[adr[15:0]]};
    
endmodule
