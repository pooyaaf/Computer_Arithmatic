`timescale 1ns/1ns
module DataPath (clk, rst, Dividend, Divisor, diviendLd, divisorLd, dividendSel, shl, sin, addSubSelect, checker, sign, validated, Q, R , OV, DivByZero);
    input [9:0] Dividend;
    input [4:0] Divisor;
    input clk, rst, diviendLd, divisorLd, dividendSel, shl, sin, addSubSelect, checker;
    output reg sign;
    output validated;
    output OV, DivByZero;
    output reg [4:0] Q, R;
    supply1 VCC;
    supply0 GND;
    //
    wire[4:0] divisor;
    wire[5:0] AddSubResult;
    wire[9:0] dividend, dividendLoadData;
    //

    InputChecker #(10,5) valid(.clk(clk), .rst(rst), .Dividend(Dividend), .Divisor(Divisor), .checker(checker), .validated(validated), .OV(OV), .DivByZero(DivByZero));

    ShiftRegister #(5) divisorReg(.PI(Divisor), .clk(clk), .rst(rst), .sin(GND), .ld(divisorLd), .shl(GND), .PO(divisor));
    ShiftRegister #(10) dividendReg(.PI(dividendLoadData), .clk(clk), .rst(rst), .sin(sin), .ld(diviendLd), .shl(shl), .PO(dividend));
    Mux #(10) mux(.A(Dividend), .B({AddSubResult,dividend[3:0]}), .sel(dividendSel), .Data(dividendLoadData));
    AddSub #(6) ALU(.A(dividend[9:4]), .B({1'b0,divisor}), .mode(addSubSelect), .SUM(AddSubResult));

    assign Q = dividend[4:0];
    assign R = dividend[9:5];
    assign sign = dividend[9];

endmodule 