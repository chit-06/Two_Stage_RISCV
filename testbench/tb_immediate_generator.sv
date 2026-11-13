`timescale 1ns / 1ps

module tb_immediate_generator;
    logic [31:0] instruction;
    logic [31:0] immediate;
    immediate_generator uut ( .instruction(instruction), .immediate(immediate));
    initial begin
        instruction = 32'h00500093;
        #10;
        if (immediate !== 32'd5)
            $fatal(1, "I-type positive test failed");
        else
            $display("I-type positive test passed");
        instruction = 32'hFFF00093;
        #10;
        if (immediate !== 32'hFFFFFFFF)
            $fatal(1, "I-type negative test failed");
        else
            $display("I-type negative test passed");
        instruction = 32'h00B02623;
        #10;
        if (immediate !== 32'd12)
            $fatal(1, "S-type positive test failed");
        else
            $display("S-type positive test passed");
        instruction = 32'hFEB02E23;
        #10;
        if (immediate !== 32'hFFFFFFFC)
            $fatal(1, "S-type negative test failed");
        else
            $display("S-type negative test passed");

        instruction = 32'h00000463;
        #10;
        if (immediate !== 32'd8)
            $fatal(1, "B-type positive test failed");
        else
            $display("B-type positive test passed");
        instruction = 32'hFE000EE3;
        #10;
        if (immediate !== 32'hFFFFFFFC)
            $fatal(1, "B-type negative test failed");
        else
            $display("B-type negative test passed");
        instruction = 32'h12345037;
        #10;
        if (immediate !== 32'h12345000)
            $fatal(1, "U-type test failed");
        else
            $display("U-type test passed");
        $display("All immediate generator tests passed");
        $finish;
    end
endmodule