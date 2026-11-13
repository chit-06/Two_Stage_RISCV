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
        repeat (2) @(posedge clk);
        @(negedge clk);
        reset = 0;
        repeat (8) @(posedge clk);
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
        $display("All RISC-V processor tests passed");
        $finish;
    end
endmodule