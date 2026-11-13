module riscv_top (input logic clk, input logic reset,
    output logic [31:0] debug_pc, output logic [31:0] debug_instruction);
    logic [31:0] pc, next_pc, pc_plus4;
    logic [31:0] instruction_fetch, instruction_stage2;
    logic [31:0] pc_stage2, pc_plus4_stage2;
    logic [6:0] opcode, funct7;
    logic [4:0] rd, rs1, rs2;
    logic [2:0] funct3;
    logic [31:0] read_data1, read_data2;
    logic [31:0] immediate, operand_a, operand_b;
    logic [31:0] alu_result, memory_read_data, writeback_data;
    logic reg_write, mem_read, mem_write, mem_to_reg;
    logic alu_src, branch, branch_ne, lui, illegal;
    logic [3:0] alu_control;
    logic zero, branch_taken;

    assign pc_plus4 = pc + 32'd4;
    assign operand_a = lui ? 32'b0 : read_data1;
    assign operand_b = alu_src ? immediate : read_data2;
    assign writeback_data = mem_to_reg ? memory_read_data : alu_result;
    assign branch_taken = branch && (branch_ne ? !zero : zero);
    assign next_pc = branch_taken ? pc_stage2 + immediate : pc_plus4;

    assign debug_pc = pc;
    assign debug_instruction = instruction_stage2;

    program_counter pc_unit (.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc));

    instruction_memory instruction_mem (.address(pc), .instruction(instruction_fetch));

    pipeline_register pipeline_reg (.clk(clk), .reset(reset), .enable(1'b1), .flush(branch_taken),
        .instruction_in(instruction_fetch), .pc_in(pc),
        .pc_plus4_in(pc_plus4), .instruction_out(instruction_stage2),
        .pc_out(pc_stage2), .pc_plus4_out(pc_plus4_stage2));

    instruction_decoder decoder (.instruction(instruction_stage2), .opcode(opcode),
        .rd(rd), .rs1(rs1), .rs2(rs2),
        .funct3(funct3), .funct7(funct7));

    control_unit control (.opcode(opcode), .funct3(funct3), .funct7(funct7),
        .reg_write(reg_write), .mem_read(mem_read),
        .mem_write(mem_write), .mem_to_reg(mem_to_reg),
        .alu_src(alu_src), .branch(branch), .branch_ne(branch_ne),
        .lui(lui), .alu_control(alu_control), .illegal(illegal));

    register_file register_file_inst (.clk(clk), .reset(reset), .write_enable(reg_write && !illegal),
        .rs1(rs1), .rs2(rs2), .rd(rd), .write_data(writeback_data),
        .read_data1(read_data1), .read_data2(read_data2));

    immediate_generator immediate_gen (.instruction(instruction_stage2), .immediate(immediate));

    alu alu_unit (.operand_a(operand_a), .operand_b(operand_b),
        .alu_control(alu_control), .result(alu_result), .zero(zero));

    data_memory data_mem (.clk(clk), .mem_read(mem_read && !illegal),
        .mem_write(mem_write && !illegal), .address(alu_result),
        .write_data(read_data2), .read_data(memory_read_data));

endmodule