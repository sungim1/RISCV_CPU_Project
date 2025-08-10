`timescale 1ns / 1ps


module ALU (
    input  [31:0] A,
    input  [31:0] B,
    input  [3:0]  ALU_Op,
    output [31:0] Result,
    output        Zero   
);

    reg [31:0] result_reg;

    always @(*) begin
        case (ALU_Op)
            4'b0000: result_reg = A + B; // ADD
            4'b0001: result_reg = A - B; // SUB
            4'b0011: result_reg = A & B; // AND
            4'b0100: result_reg = A | B; // OR
            4'b0101: result_reg = A << B; // SLL
            4'b0110: result_reg = A >> B; // SRL
            default: result_reg = 32'hxxxxxxxx;
        endcase
    end

    assign Result = result_reg;
    // 결과값이 0이면 Zero를 1로, 아니면 0으로 설정
    assign Zero = (result_reg == 32'b0);

endmodule
