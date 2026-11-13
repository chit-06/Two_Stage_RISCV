`timescale 1ns / 1ps

module tb_alu;
    logic [31:0] operand_a, operand_b;
    logic [3:0] alu_control;
    logic [31:0] result;
    logic zero;

    alu uut ( .operand_a(operand_a), .operand_b(operand_b), .alu_control(alu_control),
        .result(result), .zero(zero));
    initial begin
        operand_a = 32'd10;
        operand_b = 32'd5;
        alu_control = 4'b0000;
        #10;
        if (result !== 32'd15)
            $fatal(1, "ADD test failed");
        else
            $display("ADD test passed");
        alu_control = 4'b0001;
        #10;
        if (result !== 32'd5)
            $fatal(1, "SUB test failed");
        else
            $display("SUB test passed");
        alu_control = 4'b0010;
        #10;
        if (result !== (operand_a & operand_b))
            $fatal(1, "AND test failed");
        else
            $display("AND test passed");
        alu_control = 4'b0011;
        #10;
        if (result !== (operand_a | operand_b))
            $fatal(1, "OR test failed");
        else
            $display("OR test passed");
        alu_control = 4'b0100;
        #10;
        if (result !== (operand_a ^ operand_b))
            $fatal(1, "XOR test failed");
        else
            $display("XOR test passed");
        operand_a = 32'd5;
        operand_b = 32'd10;
        alu_control = 4'b0101;
        #10;
        if (result !== 32'd1)
            $fatal(1, "SLT test failed");
        else
            $display("SLT test passed");
        operand_a = 32'd10;
        operand_b = 32'd10;
        alu_control = 4'b0001;
        #10;
        if (result !== 32'd0 || zero !== 1'b1)
            $fatal(1, "Zero flag test failed");
        else
            $display("Zero flag test passed");
        $display("All ALU tests passed");
        $finish;
    end
endmodule