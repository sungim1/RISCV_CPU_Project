# Single-Cycle RISC-V CPU 설계 및 FPGA 구현

### 1. 프로젝트 개요 (Overview)
이 프로젝트는 Verilog HDL을 사용하여 RISC-V 32I의 기본 명령어 세트(`add`, `addi`, `sw`, `lw`, `beq`)를 지원하는 32비트 Single-Cycle CPU를 설계하고, 시뮬레이션 및 FPGA 보드를 통해 동작을 검증한 결과물입니다. 컴퓨터 구조의 핵심 원리를 실제 하드웨어로 구현하는 경험을 통해 깊이 있는 학습을 목표로 했습니다.

---

### 2. 개발 환경 (Development Environment)
* **설계 언어**: Verilog HDL
* **시뮬레이션/합성 툴**: Xilinx Vivado 2025.1
* **검증용 FPGA 보드**: Digilent Arty A7-100T

---

### 3. CPU 아키텍처 (CPU Architecture)
Single-Cycle 데이터패스 구조를 따르며, 하나의 명령어는 한 클럭 사이클에 모든 실행 단계를 마칩니다. 전체 데이터패스 구조는 아래와 같습니다.

![Datapath](doc/데이터패스_이미지_파일명.png)  
*<-- `doc` 폴더에 있는 데이터패스 이미지 파일의 이름으로 수정하세요.*

---

### 4. 구현된 모듈 설명 (Module Descriptions)
* **`rtl/`**: CPU를 구성하는 모든 Verilog 설계 파일이 들어있습니다.
    * `Single_CPU.v`: 모든 모듈을 통합한 최상위 CPU 모듈
    * `ControlUnit.v`: `opcode`를 해독하여 모든 제어 신호를 생성하는 CPU의 두뇌
    * `ALU.v`: 8가지(덧셈, 뺄셈, AND, OR 등) 산술/논리 연산을 수행
    * `RegisterFile.v`: 32개의 32비트 레지스터를 포함하는 작업 공간
    * `(자신이 만든 나머지 .v 파일에 대해 한 줄 설명을 추가하세요)`

---

### 5. 시뮬레이션 및 검증 (Simulation & Verification)
`sim/` 폴더의 테스트벤치와 프로그램을 통해 CPU의 논리적 동작을 검증했습니다. `lw`, `sw`, `add`, `addi`를 포함한 테스트 프로그램이 레지스터와 메모리에서 올바르게 실행되는 것을 아래 Waveform을 통해 확인했습니다.

**[시뮬레이션 Waveform]** ![Waveform](doc/waveform_이미지_파일명.png)  
*<-- `doc` 폴더에 있는 Waveform 스크린샷 파일의 이름으로 수정하세요.*

---

### 6. FPGA 구현 및 실제 동작
설계된 CPU를 Arty A7 보드에 구현하여 실제 하드웨어 동작을 확인했습니다. CPU가 `program.mem`의 명령어를 순차적으로 실행하며 연산한 결과(`WriteBack_Data`)의 하위 4비트가 보드의 LED를 통해 실시간으로 출력됩니다.

**[FPGA 동작 영상]** ![FPGA Demo](doc/FPGA_동작영상_파일명.gif)  
*<-- `doc` 폴더에 있는 보드 동작 영상(GIF) 파일의 이름으로 수정하세요.*
