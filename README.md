Two-Stage Pipelined RISC-V Processor

1. Project Overview

This project implements a 32-bit, two-stage pipelined RISC-V processor using SystemVerilog. The design is developed and simulated using AMD Vivado.

The processor implements a selected subset of the RV32I instruction set and demonstrates instruction fetching, decoding, execution, memory access, and register writeback.

2. Architecture

The processor consists of two pipeline stages:

**Stage 1 – Instruction Fetch (IF)**
- Program Counter (PC)
- Instruction Memory
- PC + 4 calculation

**Stage 2 – Decode, Execute, Memory and Writeback**
- Instruction Decoder
- Control Unit
- Register File
- Immediate Generator
- Arithmetic Logic Unit (ALU)
- Data Memory
- Writeback logic

An IF/EX pipeline register transfers the instruction and associated PC information between the two stages.

Branch instructions use branch-target calculation and pipeline flushing to discard incorrectly fetched sequential instructions.

3. Supported Instructions

| Instruction | Operation             |

| ADD         | Register addition     |
| SUB         | Register subtraction  |
| AND         | Bitwise AND           |
| OR          | Bitwise OR            |
| XOR         | Bitwise XOR           |
| SLT         | Signed comparison     |
| ADDI        | Immediate addition    |
| LW          | Load word             |
| SW          | Store word            |
| BEQ         | Branch if equal       |
| BNE         | Branch if not equal   |
| LUI         | Load upper immediate  |

This is a selected RV32I subset, not a complete RV32I implementation.

4. Project Structure

- `design/` – SystemVerilog processor modules.
- `testbench/` – Module-level and processor-level testbenches.
- `constraints/` – XDC clock constraint file.
- `reports/` – Vivado synthesis, utilization, timing and DRC reports.

5. Simulation and Verification

The processor was simulated using Vivado Simulator.

The integration testbench verified:

- ADDI, ADD and SUB operations.
- Load and store operations.
- BEQ and BNE branch operations.
- Branch target execution and pipeline flushing.
- Selected consecutive register dependencies.
- Invalid instruction detection.
- Register write protection for invalid instructions.

All displayed integration testbench checks passed.

## 6. Synthesis Results

Synthesis was completed successfully for the selected Virtex-7 target.

| Resource          | Used |

| Slice LUTs        | 780  |
| Slice Registers   | 568  |
| Block RAM         | 0    |
| DSPs              | 0    |

The design used a small fraction of the selected FPGA's available logic resources.

7. Timing Analysis

A 10 ns clock period (100 MHz target) was specified in the XDC constraints file.

The implementation timing report showed:

- Worst Negative Slack (WNS): -2.826 ns
- Total Negative Slack (TNS): -834.171 ns
- Failing setup endpoints: 635
- Worst Hold Slack (WHS): -0.002 ns

The design did not meet the specified 10 ns timing target. Further timing optimization is required.

8. Tools Used

- SystemVerilog
- AMD Vivado 2026.1
- Vivado Simulator (XSim)
- GitHub
- GitHub Desktop

9. Limitations and Future Improvements

- Implement forwarding and hazard detection/stalling for general RAW dependencies.
- Optimize critical timing paths.
- Extend support to additional RV32I instructions.
- Improve memory organization and FPGA resource utilization.
- Perform further verification with more comprehensive instruction programs.

10. Conclusion

A two-stage pipelined RISC-V processor was designed and implemented using SystemVerilog. The selected instruction subset passed the implemented functional simulation tests, and the design completed synthesis and FPGA implementation. Timing analysis identified violations against the 100 MHz target, providing a basis for future optimization.
