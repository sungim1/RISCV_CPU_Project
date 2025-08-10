`timescale 1ns / 1ps

module Registers (
    // Inputs
    input             clk,         // 클럭 신호
    input             RegWrite,    // 쓰기 활성화 제어 신호 (1-bit)
    input      [4:0]  ReadAddr1,   // 첫 번째 읽기 주소 (5-bit)
    input      [4:0]  ReadAddr2,   // 두 번째 읽기 주소 (5-bit)
    input      [4:0]  WriteAddr,   // 쓰기 주소 (5-bit)
    input      [31:0] WriteData,   // 쓸 데이터 (32-bit)

    // Outputs
    output     [31:0] ReadData1,   // 첫 번째 읽기 데이터 (32-bit)
    output     [31:0] ReadData2    // 두 번째 읽기 데이터 (32-bit)
);


    reg [31:0] registers [0:31];

    assign ReadData1 = (ReadAddr1 == 5'b0) ? 32'b0 : registers[ReadAddr1];
    assign ReadData2 = (ReadAddr2 == 5'b0) ? 32'b0 : registers[ReadAddr2];



    always @(posedge clk)
    begin
        if (RegWrite && (WriteAddr != 5'b00000)) 
        begin
            registers[WriteAddr] <= WriteData;
        end
    end
    

    integer i;
    initial begin
        for (i=0; i<32; i=i+1) 
        begin
            registers[i] = 32'b0;
        end
    end

endmodule