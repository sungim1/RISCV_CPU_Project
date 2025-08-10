`timescale 1ns / 1ps


module PC (
    input             clk,      // 클럭 신호
    input             rst,      // 리셋 신호 (0에서 시작하도록)
    input      [31:0] NextPC,   // 다음 PC 값 
    output reg [31:0] PCOut     // 현재 PC 값
);

    always @(posedge clk or posedge rst) begin
        // 리셋 신호(rst)가 1이면, PC를 0으로 강제 초기화
        if (rst) begin
            PCOut <= 32'h00000000;
        end
        // 리셋이 아니면, NextPC 입력 값을 받아서 PCOut을 업데이트
        else begin
            PCOut <= NextPC;
        end
    end

endmodule
