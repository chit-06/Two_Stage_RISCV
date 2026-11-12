
`timescale 1ns / 1ps

module tb_program_counter;

    // Testbench signals
    logic clk;
    logic reset;
    logic [31:0] next_pc;
    logic [31:0] pc;

    // Instantiate the Program Counter
    program_counter uut (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Generate clock: 10 ns period
    always #5 clk = ~clk;

    initial begin

        // Initial values
        clk = 0;
        reset = 1;
        next_pc = 32'h00000000;

        // Test 1: Reset
        @(posedge clk);
        #1;
        if (pc !== 32'h00000000)
            $fatal(1, "RESET TEST FAILED: PC = %h", pc);
        else
            $display("RESET TEST PASSED");

        // Test 2: Sequential execution
        @(negedge clk);
        reset = 0;
        next_pc = 32'h00000004;

        @(posedge clk);
        #1;
        if (pc !== 32'h00000004)
            $fatal(1, "TEST 2 FAILED: PC = %h", pc);
        else
            $display("TEST 2 PASSED: PC = %h", pc);

        // Test 3: Next instruction
        @(negedge clk);
        next_pc = 32'h00000008;

        @(posedge clk);
        #1;
        if (pc !== 32'h00000008)
            $fatal(1, "TEST 3 FAILED: PC = %h", pc);
        else
            $display("TEST 3 PASSED: PC = %h", pc);

        // Test 4: Branch target address
        @(negedge clk);
        next_pc = 32'h00000020;

        @(posedge clk);
        #1;
        if (pc !== 32'h00000020)
            $fatal(1, "TEST 4 FAILED: PC = %h", pc);
        else
            $display("TEST 4 PASSED: PC = %h", pc);

        $display("--------------------------------");
        $display("ALL PROGRAM COUNTER TESTS PASSED");
        $display("--------------------------------");

        $finish;

    end

endmodule
