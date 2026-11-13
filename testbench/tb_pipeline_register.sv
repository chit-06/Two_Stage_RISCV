`timescale 1ns / 1ps

module tb_pipeline_register;
    logic clk;
    logic reset;
    logic enable;
    logic flush;
    logic [31:0] instruction_in;
    logic [31:0] pc_in;
    logic [31:0] pc_plus4_in;
    logic [31:0] instruction_out;
    logic [31:0] pc_out;
    logic [31:0] pc_plus4_out;

    pipeline_register uut ( .clk(clk), .reset(reset), .enable(enable), .flush(flush),
        .instruction_in(instruction_in), .pc_in(pc_in),
        .pc_plus4_in(pc_plus4_in), .instruction_out(instruction_out),
        .pc_out(pc_out), .pc_plus4_out(pc_plus4_out));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        flush = 0;
        instruction_in = 0;
        pc_in = 0;
        pc_plus4_in = 0;
        @(posedge clk);
        #1;
        if (instruction_out !== 32'h00000013 || pc_out !== 0 || pc_plus4_out !== 0)
            $fatal(1, "Reset test failed");
        else
            $display("Reset test passed");
        @(negedge clk);
        reset = 0;
        enable = 1;
        instruction_in = 32'h00500093;
        pc_in = 32'h00000000;
        pc_plus4_in = 32'h00000004;
        @(posedge clk);
        #1;
        if (instruction_out !== 32'h00500093 || pc_out !== 0 || pc_plus4_out !== 4)
            $fatal(1, "Pipeline transfer test failed");
        else
            $display("Pipeline transfer test passed");
        @(negedge clk);
        enable = 0;
        instruction_in = 32'h00A00113;
        pc_in = 32'h00000004;
        pc_plus4_in = 32'h00000008;
        @(posedge clk);
        #1;
        if (instruction_out !== 32'h00500093 || pc_out !== 0 || pc_plus4_out !== 4)
            $fatal(1, "Pipeline hold test failed");
        else
            $display("Pipeline hold test passed");
        @(negedge clk);
        enable = 1;
        flush = 1;
        @(posedge clk);
        #1;
        if (instruction_out !== 32'h00000013 || pc_out !== 0 || pc_plus4_out !== 0)
            $fatal(1, "Pipeline flush test failed");
        else
            $display("Pipeline flush test passed");
        $display("All pipeline register tests passed");
        $finish;
    end
endmodule