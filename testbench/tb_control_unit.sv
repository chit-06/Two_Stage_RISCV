`timescale 1ns / 1ps

module tb_control_unit;
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic reg_write, mem_read, mem_write;
    logic mem_to_reg, alu_src, branch, branch_ne, lui, illegal;
    logic [3:0] alu_control;
    control_unit uut (.opcode(opcode), .funct3(funct3), .funct7(funct7), .reg_write(reg_write),
        .mem_read(mem_read), .mem_write(mem_write), .mem_to_reg(mem_to_reg), .alu_src(alu_src),
        .branch(branch), .branch_ne(branch_ne), .lui(lui), .alu_control(alu_control),
        .illegal(illegal));
    task automatic check(input logic [12:0] expected, input string test_name);
        #10;
        if ({reg_write, mem_read, mem_write, mem_to_reg, alu_src,
             branch, branch_ne, lui, illegal, alu_control} !== expected)
            $fatal(1, "%s failed", test_name);
        else
            $display("%s passed", test_name);
    endtask
    initial begin
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        check(13'b1000000000000, "ADD");
        funct7 = 7'b0100000;
        check(13'b1000000000001, "SUB");
        opcode = 7'b0010011;
        funct3 = 3'b000;
        funct7 = 0;
        check(13'b1000100000000, "ADDI");
        opcode = 7'b0000011;
        funct3 = 3'b010;
        check(13'b1101100000000, "LW");
        opcode = 7'b0100011;
        check(13'b0010100000000, "SW");
        opcode = 7'b1100011;
        funct3 = 3'b000;
        check(13'b0000010000001, "BEQ");
        funct3 = 3'b001;
        check(13'b0000011000001, "BNE");
        opcode = 7'b0110111;
        funct3 = 0;
        check(13'b1000100100000, "LUI");
        opcode = 7'b1111111;
        check(13'b0000000010000, "Invalid instruction");
        $display("All control unit tests passed");
        $finish;
    end
endmodule