`timescale 1ns / 1ps

module tb_Registers;


    reg         clk;
    reg         RegWrite;
    reg  [4:0]  ReadAddr1, ReadAddr2, WriteAddr;
    reg  [31:0] WriteData;
    wire [31:0] ReadData1, ReadData2;


    Registers u_reg (
        .clk(clk),
        .RegWrite(RegWrite),
        .ReadAddr1(ReadAddr1),
        .ReadAddr2(ReadAddr2),
        .WriteAddr(WriteAddr),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Clock 생성
    always #5 clk = ~clk;


    initial begin
        clk = 0;
        RegWrite = 0;
        WriteAddr = 0;
        WriteData = 0;
        
        $display("----------------------------------------");
        $display("Register File Test Start!");
        $display("----------------------------------------");

        #10; // 10ns 대기

        $display("[Time: %0t] Writing 0xAAAAAAAA to Register 5...", $time);
        RegWrite = 1;       // 쓰기 활성화
        WriteAddr = 5'd5;
        WriteData = 32'hAAAAAAAA;
        #10; 
        
        RegWrite = 0; // 쓰기 비활성화 (실수로 다른 곳에 쓰는 것을 방지)
        #1; // 신호 안정화를 위해 잠시 대기

        $display("[Time: %0t] Reading from Register 5 and 10...", $time);
        ReadAddr1 = 5'd5;
        ReadAddr2 = 5'd10;
        #9; // 1ns + 9ns = 10ns. 다음 클럭 엣지 직전까지 관찰

        $display(" -> Read from R5: %h (Expected: AAAAAAAA)", ReadData1);
        $display(" -> Read from R10: %h (Expected: 00000000)", ReadData2);
        #10;


        $display("[Time: %0t] Attempting to write 0xDEADBEEF to Register 0...", $time);
        RegWrite = 1;
        WriteAddr = 5'd0;
        WriteData = 32'hDEADBEEF; // 의미 없는 값
        #10; // 클럭 엣지까지 대기
        RegWrite = 0;
        #1;


        $display("[Time: %0t] Reading from Register 0...", $time);
        ReadAddr1 = 5'd0;
        #9;
        $display(" -> Read from R0: %h (Expected: 00000000)", ReadData1);
        
        $display("----------------------------------------");
        $display("Register File Test End!");
        $display("----------------------------------------");
        
        $stop; 
    end

endmodule

