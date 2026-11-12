`timescale 1ns / 1ps

module tb_program_counter;
    logic clk;
    logic reset;
    logic [31:0] next_pc;
    logic [31:0] pc;
    program_counter uut ( .clk(clk),.reset(reset),.next_pc(next_pc),.pc(pc));
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        next_pc = 32'h00000000;
        @(posedge clk);
        #1;
        if (pc !== 32'h00000000)
            $fatal(1, "Reset test failed: PC = %h", pc);
        else
            $display("Reset test passed");
        @(negedge clk);
        reset = 0;
        next_pc = 32'h00000004;
        @(posedge clk);
        #1;
        if (pc !== 32'h00000004)
            $fatal(1, "Test 2 failed: PC = %h", pc);
        else
            $display("Test 2 passed: PC = %h", pc);
        @(negedge clk);
        next_pc = 32'h00000008;
        @(posedge clk);
        #1;
        if (pc !== 32'h00000008)
            $fatal(1, "Test 3 failed: PC = %h", pc);
        else
            $display("Test 3 passed: PC = %h", pc);
        @(negedge clk);
        next_pc = 32'h00000020;
        @(posedge clk);
        #1;
        if (pc !== 32'h00000020)
            $fatal(1, "Test 4 failed: PC = %h", pc);
        else
            $display("Test 4 passed: PC = %h", pc);
        $display("All program counter tests passed");
        $finish;
    end
endmodule