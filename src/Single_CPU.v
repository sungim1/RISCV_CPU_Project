`timescale 1ns / 1ps


module Single_CPU(
    input clk,
    input rst,
    output [31:0] debug_WriteBackData

);
    // --- PC 및 명령어 흐름 ---
    wire [31:0] PC_in, PC_out;
    wire [31:0] PC_4, branch_addr;
    wire [31:0] Instruction;

    // --- 명령어 분해 (디코딩) ---
    wire [6:0]  opcode;
    wire [4:0]  rs1, rs2, rd;
    wire [2:0]  funct3;
    wire [6:0]  funct7;

    // --- 제어 신호  ---
    wire        RegWrite, MemtoReg, ALUSrc, Branch, MemRead, MemWrite;
    wire [1:0]  ALUOp;

    // --- 레지스터 파일 및 상수 ---
    wire [31:0] Reg_out1, Reg_out2;
    wire [31:0] Inst_Imm;

    // --- ALU 및 주변 ---
    wire [31:0] ALU_in2;
    wire [31:0] ALU_out;
    wire        Zero;
    wire [3:0]  ALU_Control_Out;

    // --- 데이터 메모리 및 최종 결과 ---
    wire [31:0] DataMem_out;
    wire [31:0] WriteBack_Data;
    

    wire PCSrc;



    // 1. Fetch & 2. Decode 단계 

    Mux2to1 u_PC_Mux ( .A(PC_4),
                       .B(branch_addr), 
                       .Sel(PCSrc), 
                       .Out(PC_in) );
   
    PC u_PC ( .clk(clk), 
              .rst(rst), 
              .NextPC(PC_in), 
              .PCOut(PC_out) );
    
    Adder u_PC4_Adder ( .A(PC_out), 
                        .B(32'd4), 
                        .Sum(PC_4) );
   
    //Ins_Mem u_Ins_Mem ( .Address(PC_out), 
                    //    .Instruction(Instruction) );
   blk_mem_gen_0 u_instance_name (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(PC_out[11:2]),  // input wire [3 : 0] addra
  .dina(32'b0),    // input wire [31 : 0] dina
  .douta(Instruction)  // output wire [31 : 0] douta
);

    assign opcode = Instruction[6:0];
    assign rd     = Instruction[11:7];
    assign funct3 = Instruction[14:12];
    assign rs1    = Instruction[19:15];
    assign rs2    = Instruction[24:20];
    assign funct7 = Instruction[31:25];
    
    ControlUnit u_ControlUnit (.opcode(opcode),
                               .RegWrite(RegWrite),
                               .MemtoReg(MemtoReg),
                               .Branch(Branch),
                               .ALUSrc(ALUSrc),
                               .ALUOp(ALUOp),
                               .MemWrite(MemWrite),
                               .MemRead(MemRead) );

                               
    

    // 3. Execute ~ 5. Write-Back 단계 
    Registers u_Registers ( .clk(clk), 
                            .RegWrite(RegWrite), 
                            .ReadAddr1(rs1), 
                            .ReadAddr2(rs2), 
                            .WriteAddr(rd), 
                            .WriteData(WriteBack_Data), 
                            .ReadData1(Reg_out1), 
                            .ReadData2(Reg_out2) );
    
    ImmGen u_ImmGen ( .inst(Instruction), 
                      .imm_out(Inst_Imm) );
   
    Mux2to1 u_ALU_Mux ( .A(Reg_out2), 
                        .B(Inst_Imm), 
                        .Sel(ALUSrc), 
                        .Out(ALU_in2) );

    ALUControl u_ALU_Ctrl ( .ALUOp(ALUOp),
                            .funct3(funct3), 
                            .funct7_5(funct7[5]), 
                            .ALUOperation(ALU_Control_Out) );
    
    ALU u_ALU ( .A(Reg_out1), 
                .B(ALU_in2), 
                .ALU_Op(ALU_Control_Out), 
                .Result(ALU_out), 
                .Zero(Zero) );
    
    Data_Mem u_Data_Mem ( .clk(clk), 
                          .MemWrite(MemWrite), 
                          .MemRead(MemRead), 
                          .Address(ALU_out), 
                          .WriteData(Reg_out2), 
                          .ReadData(DataMem_out) );
   
    Mux2to1 u_WriteBack_Mux ( .A(ALU_out), 
                              .B(DataMem_out), 
                              .Sel(MemtoReg), 
                              .Out(WriteBack_Data) );
    

    //Branch 로직

    Adder u_BranchAddr_Adder ( .A(PC_out), 
                               .B(Inst_Imm), 
                               .Sum(branch_addr) );
    assign PCSrc = Branch & Zero;
    
    
    // 디버깅용 출력 연결
    assign debug_WriteBackData = WriteBack_Data;
 

endmodule