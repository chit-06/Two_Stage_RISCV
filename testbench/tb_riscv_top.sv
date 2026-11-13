`timescale 1ns / 1ps

module tb_riscv_top;
    logic clk;
    logic reset;
    logic [31:0] debug_pc;
    logic [31:0] debug_instruction;

    riscv_top uut (.clk(clk), .reset(reset),
        .debug_pc(debug_pc),
        .debug_instruction(debug_instruction));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        repeat (26) @(posedge clk);
        @(negedge clk);
        reset = 0;
        repeat (26) @(posedge clk);
        #1;
        if (uut.register_file_inst.registers[1] !== 32'd5)
            $fatal(1, "ADDI x1 test failed");
        else
            $display("ADDI x1 test passed");
        if (uut.register_file_inst.registers[2] !== 32'd10)
            $fatal(1, "ADDI x2 test failed");
        else
            $display("ADDI x2 test passed");
        if (uut.register_file_inst.registers[3] !== 32'd15)
            $fatal(1, "ADD x3 test failed");
        else
            $display("ADD x3 test passed");
        if (uut.register_file_inst.registers[4] !== 32'd5)
            $fatal(1, "SUB x4 test failed");
        else
            $display("SUB x4 test passed");
        if (uut.data_mem.memory[0] !== 32'd15)
            $fatal(1, "SW test failed");
        else
            $display("SW test passed");
        if (uut.register_file_inst.registers[5] !== 32'd15)
            $fatal(1, "LW test failed");
        else
            $display("LW test passed");
        if (uut.register_file_inst.registers[6] !== 32'd0)
            $fatal(1, "BEQ flush test failed");
        else
            $display("BEQ flush test passed");
        if (uut.register_file_inst.registers[7] !== 32'd7)
            $fatal(1, "BEQ target test failed");
        else
            $display("BEQ target test passed");
        if (uut.register_file_inst.registers[9] !== 32'd0)
            $fatal(1, "BNE flush test failed");
        else
            $display("BNE flush test passed");
        if (uut.register_file_inst.registers[8] !== 32'd8)
            $fatal(1, "BNE target test failed");
        else
            $display("BNE target test passed");
        if (uut.register_file_inst.registers[10] !== 32'd3)
            $fatal(1, "First dependency test failed");
        else
            $display("First dependency test passed");
        if (uut.register_file_inst.registers[11] !== 32'd7)
            $fatal(1, "Second dependency test failed");
        else
            $display("Second dependency test passed");
        if (uut.register_file_inst.registers[12] !== 32'd10)
            $fatal(1, "Third dependency test failed");
        else
            $display("Third dependency test passed");
        $display("All RISC-V processor tests passed");
        $finish;
    end
endmodule