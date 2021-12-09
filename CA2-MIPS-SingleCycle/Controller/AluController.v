`timescale 1ns/1ns
module AluController(input [1:0] AluOp, input [5:0] Func, output reg [2:0]  AluOperation);
    parameter [5:0] sum = 6'b000001, sub = 6'b000010,And = 6'b000100,Or = 6'b001000, slt = 6'b010000;
    always @(AluOp, Func) begin
        AluOperation = 3'b000;
        case(AluOp)
            2'b00 :
                AluOperation = 3'b000;
            2'b01 : 
                AluOperation = 3'b001;
            2'b10 :
                AluOperation = 3'b111;
            2'b11 : begin
                case(Func)
                    sum :
                        AluOperation = 3'b000;
                    sub :
                        AluOperation = 3'b001;
                    And :
                        AluOperation = 3'b010;
                    Or  :
                        AluOperation = 3'b011;
                    slt :
                        AluOperation = 3'b111;

                endcase
            end 
        endcase
    end
endmodule
