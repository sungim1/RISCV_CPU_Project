`timescale 1ns / 1ps


module Mux2to1 (
    input  [31:0] A,      // 0번 입력
    input  [31:0] B,      // 1번 입력
    input         Sel,    //  1bit 선택 신호 (0이면 A, 1이면 B 선택)
    output [31:0] Out     // 선택된 출력
);

    // Sel 신호가 1'b0 (0)이면 A를, 그렇지 않으면(1이면) B를 선택하여 Out으로 내보냅니다.
    assign Out = (Sel == 1'b0) ? A : B;

endmodule

