`timescale 1ns / 1ps


module ImmGen (
    input  [31:0] inst,     // 32비트 명령어
    output [31:0] imm_out   // 생성된 32비트 상수
);
    reg [31:0] imm_out_reg;
    wire [6:0] opcode;

    assign opcode = inst[6:0];

    always @(*) begin
        case (opcode)
            // I-type (addi, lw)
            7'b0010011, 7'b0000011:
                imm_out_reg = {{20{inst[31]}}, inst[31:20]};
            
            // S-type (sw)
            7'b0100011:
                imm_out_reg = {{20{inst[31]}}, inst[31:25], inst[11:7]};

            // B-type (beq) 
            // 7'b1100011:
            //     imm_out_reg = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
            
            default: imm_out_reg = 32'hxxxxxxxx; 
        endcase
    end

    assign imm_out = imm_out_reg;

endmodule