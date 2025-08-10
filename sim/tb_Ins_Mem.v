`timescale 1ns / 1ps

module tb_Ins_Mem;

    reg  [31:0] Address;       // 테스트용 주소
    wire [31:0] Instruction;   // 읽어온 명령어

    Ins_Mem uut (
        .Address(Address),
        .Instruction(Instruction)
    );

    initial begin

        $display("==== Instruction Memory Test ====");
        
        // 주소 0에서 읽기
        Address = 32'd0;
        #1; 
        $display("Address: %d -> Instruction: %b", Address, Instruction);

        // 주소 4에서 읽기
        Address = 32'd4;
        #1;
        $display("Address: %d -> Instruction: %b", Address, Instruction);

        // 주소 8에서 읽기
        Address = 32'd8;
        #1;
        $display("Address: %d -> Instruction: %b", Address, Instruction);

        // 주소 12에서 읽기
        Address = 32'd12;
        #1;
        $display("Address: %d -> Instruction: %b", Address, Instruction);

        // 테스트 종료
        $finish;
    end

endmodule