`timescale 1ns / 1ps
module ClockDivider (
    input  fast_clk, // 보드로부터 들어오는 100MHz 클럭
    input  rst,      // 리셋 신호
    output reg slow_clk  // CPU에 공급할 느린 클럭
);


    reg [24:0] counter;

    always @(posedge fast_clk) begin
    
        if (rst) begin
            counter <= 0;
            slow_clk <= 0;
        end
        else begin
            if (counter == 25'd24999999) begin
                counter <= 0;
                slow_clk <= ~slow_clk;
            end
            else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
                            