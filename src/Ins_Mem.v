`timescale 1ns / 1ps

module Ins_Mem (
    input  [31:0] Address,      // PC로부터 받는 명령어 주소
    output [31:0] Instruction   // 해당 주소의 32비트 명령어
);


    reg [31:0] mem [0:1023];

    initial begin
        $readmemb("program.mem", mem); // program.mem 파일에서 2진수 프로그램 코드를 읽어옴
    end

    // 읽기 동작 (조합 논리)
    // Byte 주소를 Word 주소로 변환하여 사용 (하위 2비트를 버림)
    // 예: 주소 0,1,2,3 -> 인덱스 0 / 주소 4,5,6,7 -> 인덱스 1
    assign Instruction = mem[Address[31:2]];

endmodule