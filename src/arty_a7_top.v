module arty_a7_top (
    input  clk,       // 100MHz 시스템 클럭
    input  cpu_rst,   // 보드의 리셋 버튼
    output [3:0] led // 보드의 LED 4개
);

 
    wire slow_clk;
    wire rst; 
    wire [31:0] cpu_debug_data;

   
    assign rst = ~cpu_rst;

    ClockDivider u_clk_div (
        .fast_clk(clk),
        .rst(rst), 
        .slow_clk(slow_clk)
    );

    Single_CPU u_cpu (
        .clk(slow_clk),     // CPU에는 느린 클럭을 공급
        .rst(rst),  
        .debug_WriteBackData(cpu_debug_data)
    );

    assign led = cpu_debug_data[3:0];

endmodule

