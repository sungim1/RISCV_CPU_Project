`timescale 1ns / 1ps


module ControlUnit(
   input [6:0] opcode,
   output reg RegWrite,
   output reg MemtoReg,
   output reg Branch,
   output reg ALUSrc,
   output reg [1:0] ALUOp,
   output reg MemWrite,
   output reg MemRead
     
    );
    
    always @(*) begin
    RegWrite = 1'b0;
    MemtoReg = 1'b0;
    Branch   = 1'b0;
    ALUSrc   = 1'b0;
    ALUOp    = 2'b00;
    MemWrite = 1'b0;
    MemRead  = 1'b0;
    
     
     case(opcode)
    // R-type (add, sub, and, or, ...)
    7'b0110011: begin
        RegWrite = 1'b1;    // 결과를 레지스터에 쓴다.
        ALUSrc   = 1'b0;    // ALU 입력 B는 레지스터 값(rs2)이다.
        ALUOp    = 2'b10;    // ALU가 R-type 연산을 하도록 지시한다.
    end
    
    // I-type (addi) - 최종 테스트를 위해 포함
    7'b0010011: begin
        RegWrite = 1'b1;    // 결과를 레지스터에 쓴다.
        ALUSrc   = 1'b1;    // ALU 입력 B는 상수 값이다.
        ALUOp    = 2'b00;    // ALU가 덧셈을 하도록 지시한다.
    end
    
    // lw (load word) 명령어
    7'b0000011: begin
        RegWrite = 1'b1;    // 결과를 레지스터에 쓴다.
        ALUSrc   = 1'b1;    // ALU 입력 B는 주소 계산을 위한 상수.
        MemtoReg = 1'b1;    // 레지스터에 쓸 데이터는 메모리에서 온다.
        MemRead  = 1'b1;    // 데이터 메모리를 읽는다.
        ALUOp    = 2'b00;    // ALU는 주소 계산을 위해 덧셈 수행.
    end

    // sw (store word) 명령어
    7'b0100011: begin
        ALUSrc   = 1'b1;    // ALU 입력 B는 주소 계산을 위한 상수.
        MemWrite = 1'b1;    // 데이터 메모리에 쓴다.
        ALUOp    = 2'b00;    // ALU는 주소 계산을 위해 덧셈 수행.
    end

    // beq (branch if equal) 명령어
    7'b1100011: begin
        Branch   = 1'b1;   
        ALUSrc   = 1'b0;    // ALU 입력 B는 비교할 레지스터 값(rs2).
        ALUOp    = 2'b01;    // ALU가 뺄셈을 하도록 지시(결과가 0인지 확인).
    end
    
 
    default: begin
        RegWrite = 1'b0;
        MemtoReg = 1'b0;
        Branch   = 1'b0;
        ALUSrc   = 1'b0;
        ALUOp    = 2'b00;
        MemWrite = 1'b0;
        MemRead  = 1'b0;
    end
endcase

end
endmodule
