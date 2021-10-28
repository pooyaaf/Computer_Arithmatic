`timescale 1ns/1ns
module DataPath (clk,rst,Dividend, Divisor, diviendLd, divisorLd, dividendSel, shl, sin, addSubSelect, sign, Q, R);
    input [9:0] Dividend;
    input [4:0] Divisor;
    input clk,rst,diviendLd, divisorLd, dividendSel, shl, sin, addSubSelect;
    output sign;
    output [4:0] Q, R;
    supply1 VCC;
    supply0 GND;
    //
    wire[4:0] divisor;
    wire[5:0] AddSubResult;
    wire[9:0] dividend, dividendLoadData;
    //
    ShiftRegister #(5) divisorReg(Divisor,clk,rst,GND,divisorLd,GND,divisor);
    ShiftRegister #(10) dividendReg(dividendLoadData,clk,rst,sin,diviendLd,shl,dividend);
    Mux #(10) mux(Dividend,{AddSubResult,dividend[3:0]},dividendSel,dividendLoadData);
    AddSub #(6) ALU(dividend[9:4],{1'b0,divisor},addSubSelect,AddSubResult);

    assign Q = dividend[4:0];
    assign R = dividend[9:5];
    assign sign = dividend[9];
endmodule 