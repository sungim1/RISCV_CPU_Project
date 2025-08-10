`timescale 1ns / 1ps

module tb_Single_CPU;


    reg clk;
    reg rst;

    wire [31:0] debug_data;


    Single_CPU u_cpu (
        .clk(clk),
        .rst(rst),
        .debug_WriteBackData(debug_data) 
    );
    
    // Clock 생성 (10ns 주기)
    always #5 clk = ~clk;


    initial begin

        clk = 0;
        rst = 1;

        $display("======= CPU Simulation Start! =======");
        $display("Time\t| WriteBack Data (Hex)");
        $monitor("%0t\t| %h", $time, debug_data);

        #20; // 20ns 동안 리셋 상태를 유지
        rst = 0;

        #100;


        $display("======== CPU Simulation End! ========");
        $stop; // 시뮬레이션 종료
    end

endmodule