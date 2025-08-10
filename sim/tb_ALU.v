`timescale 1ns / 1ps


module tb_ALU; 


    reg  [31:0] tb_A;
    reg  [31:0] tb_B;
    reg  [3:0]  tb_ALU_Op;

    wire [31:0] tb_Result;


    ALU u_ALU (
        .A(tb_A),          
        .B(tb_B),          
        .ALU_Op(tb_ALU_Op), 
        .Result(tb_Result)  
    );


    initial begin

        $display("========================================");
        $display("ALU Testbench Simulation Start!");
        $display("========================================");

        // 1. 덧셈 테스트 (A=10, B=5, Op=0000)
        tb_A = 32'd10;
        tb_B = 32'd5;
        tb_ALU_Op = 4'b0000;
        #10; // 10ns 대기 후 결과 확인
        $display("Test 1: ADD | A=%d, B=%d, Op=%b => Result=%d", tb_A, tb_B, tb_ALU_Op, tb_Result);

        // 2. 뺄셈 테스트 (A=20, B=7, Op=0001)
        tb_A = 32'd20;
        tb_B = 32'd7;
        tb_ALU_Op = 4'b0001;
        #10;
        $display("Test 2: SUB | A=%d, B=%d, Op=%b => Result=%d", tb_A, tb_B, tb_ALU_Op, tb_Result);
        
        // 3. 곱셈 테스트 (A=6, B=7, Op=0010)
        tb_A = 32'd6;
        tb_B = 32'd7;
        tb_ALU_Op = 4'b0010;
        #10;
        $display("Test 3: MUL | A=%d, B=%d, Op=%b => Result=%d", tb_A, tb_B, tb_ALU_Op, tb_Result);
        
        // 4. AND 테스트 (A=12(1100), B=10(1010), Op=0011)
        tb_A = 32'b00001100;
        tb_B = 32'b00001010;
        tb_ALU_Op = 4'b0011;
        #10; // AND 결과는 8 (1000)
        $display("Test 4: AND | A=%b, B=%b, Op=%b => Result=%b", tb_A, tb_B, tb_ALU_Op, tb_Result);

        // 5. OR 테스트 (A=12(1100), B=10(1010), Op=0100)
        tb_A = 32'b00001100;
        tb_B = 32'b00001010;
        tb_ALU_Op = 4'b0100;
        #10; // OR 결과는 14 (1110)
        $display("Test 5: OR  | A=%b, B=%b, Op=%b => Result=%b", tb_A, tb_B, tb_ALU_Op, tb_Result);

        // 6. 왼쪽 쉬프트 테스트 (A=1, B=4, Op=0101)
        tb_A = 32'd1;
        tb_B = 32'd4;
        tb_ALU_Op = 4'b0101;
        #10; // 1 << 4 = 16
        $display("Test 6: SLL | A=%d, B=%d, Op=%b => Result=%d", tb_A, tb_B, tb_ALU_Op, tb_Result);

        // 7. 오른쪽 쉬프트 테스트 (A=16, B=2, Op=0110)
        tb_A = 32'd16;
        tb_B = 32'd2;
        tb_ALU_Op = 4'b0110;
        #10; // 16 >> 2 = 4
        $display("Test 7: SRL | A=%d, B=%d, Op=%b => Result=%d", tb_A, tb_B, tb_ALU_Op, tb_Result);
        
        $display("========================================");
        $display("ALU Testbench Simulation End!");
        $display("========================================");
        
        #10;
        $stop; 
    end

endmodule