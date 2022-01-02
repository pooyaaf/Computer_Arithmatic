`timescale 1ns/1ns

module Controller( regSrc, regDst, pcSrc, ALUSrc, ALUOp, regWrite, memWrite,memRead , flush, zero, opCode, func);
input zero;
input[5:0] opCode,func;
output reg [1:0] regDst = 0,regSrc = 0 ,pcSrc = 0,ALUOp = 0;
output reg ALUSrc = 0,regWrite = 0,memWrite = 0,memRead = 0,flush = 0;

parameter [5:0]
	RTYPE = 0,ADDI = 8,SLTI = 10,LW = 35,SW = 43,J = 2,JAL = 3,BEQ = 4,BNE = 5;

parameter [5:0]
	ADD = 32,SUB = 34,AND = 17 , OR =7 ,SLT = 42 , JR =  8;

reg[2:0] ALUcontrol = 0;
reg [1:0] branchOC;
always@(opCode, func)begin
	{regDst,regSrc,pcSrc,ALUcontrol,ALUSrc,regWrite,memWrite,branchOC,memRead} = 0;
	case(opCode)
		RTYPE:begin regSrc=2; regWrite= func==8 ? 0 : 1; memWrite=0; ALUSrc=0; regDst=1; ALUcontrol=3;  branchOC=0;end
		ADDI: begin regSrc=2; regWrite=1; memWrite=0;		     ALUSrc=1; regDst=0; ALUcontrol=0;  branchOC=0; end
		SLTI: begin regSrc=2; regWrite=1; memWrite=0; 		     ALUSrc=1; regDst=1; ALUcontrol=2;  branchOC=0; end
		LW:   begin regSrc=1; regWrite=1; memWrite=0; 	memRead=1;   ALUSrc=1; regDst=0; ALUcontrol=0;  branchOC=0; end
		SW:   begin regSrc=0; regWrite=0; memWrite=1; 		     ALUSrc=1; regDst=0; ALUcontrol=0;  branchOC=0; end
		J:    begin regSrc=0; regWrite=0; memWrite=0;     	     ALUSrc=0; regDst=0; ALUcontrol=0;  branchOC=2;  end
		JAL:  begin regSrc=0; regWrite=1; memWrite=0; 		     ALUSrc=0; regDst=2; ALUcontrol=0;  branchOC=2;  end
		BEQ:  begin regSrc=0; regWrite=0; memWrite=0; 		     ALUSrc=0; regDst=0; ALUcontrol=1;  branchOC=1;  end
		BNE:  begin regSrc=0; regWrite=0; memWrite=0; 		     ALUSrc=0; regDst=0; ALUcontrol=1;  branchOC=3;  end
		endcase
end

reg branchF;
always@(func, ALUcontrol)begin
	ALUOp = 0;branchF=0;
	if(ALUcontrol == 3)begin
		case(func)
			ADD:ALUOp = 1;
			SUB:ALUOp = 2;
			AND: ALUOp = 3;
       		OR: ALUOp  = 4;
			SLT:ALUOp = 5;
			JR: branchF = 1;
		endcase
	end
	else
		ALUOp = ALUcontrol;
end
always@(zero, branchF, branchOC)begin
	pcSrc = 0;flush = 0;
	if(branchF == 1) pcSrc = 3;
	else if(branchOC == 1)begin pcSrc = {1'b0,zero}; flush=zero; end
	else if(branchOC == 2) pcSrc = 2;
	else if(branchOC == 3)begin pcSrc = {1'b0,~zero}; flush=~zero; end
end

endmodule