`timescale 1ns / 1ps

module Data_Mem (
    // Inputs
    input             clk,        // 클럭
    input             MemWrite,   // 쓰기 활성화 신호 (store 명령어일 때 1)
    input             MemRead,    // 읽기 활성화 신호 (load 명령어일 때 1) 
    input      [31:0] Address,    // 주소 (ALU의 결과)
    input      [31:0] WriteData,  // 메모리에 쓸 데이터

   
    output     [31:0] ReadData    // 메모리에서 읽은 데이터
);

    reg [31:0] mem [0:1023];

    assign ReadData = mem[Address[31:2]];


    always @(posedge clk) begin
        if (MemWrite) begin
            mem[Address[31:2]] <= WriteData;
        end
    end
    
   
    integer i;
    initial begin
        for (i=0; i<1024; i=i+1) begin
            mem[i] = 32'b0;
        end
    end

endmodule