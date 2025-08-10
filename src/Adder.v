`timescale 1ns / 1ps



module Adder (
    input  [31:0] A,    // 32비트 첫 번째 입력
    input  [31:0] B,    // 32비트 두 번째 입력
    output [31:0] Sum  // 32비트 덧셈 결과
);

    
    assign Sum = A + B;

endmodule