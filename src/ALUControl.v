`timescale 1ns / 1ps


module ALUControl (
    input  [1:0] ALUOp,     
    input  [2:0] funct3,    
    input        funct7_5,  
    output reg [3:0] ALUOperation // ALU에 전달할 최종 4비트 연산 신호
);

    // ALUOp 신호에 따라 최종 ALU 연산 코드를 결정
    always @(*) begin
        case(ALUOp)
           
            2'b00: begin
                ALUOperation = 4'b0000; 
            end
            
           
            2'b10: begin
                
                case({funct7_5, funct3}) 
                    4'b0000: ALUOperation = 4'b0000; // ADD
                    4'b1000: ALUOperation = 4'b0001; // SUB
                    4'b0111: ALUOperation = 4'b0011; // AND
                    4'b0110: ALUOperation = 4'b0100; // OR
                   
                    default: ALUOperation = 4'bxxxx; // 정의되지 않은 경우
                endcase
            end
            
            default: ALUOperation = 4'bxxxx; // 정의되지 않은 경우
        endcase
    end

endmodule
