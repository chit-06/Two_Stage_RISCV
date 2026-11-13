`timescale 1ns / 1ps

module tb_instruction_decoder;
    logic [31:0] instruction;
    logic [6:0] opcode;
    logic [4:0] rd, rs1, rs2;
    logic [2:0] funct3;
    logic [6:0] funct7;
    instruction_decoder uut (.instruction(instruction), .opcode(opcode), .rd(rd),
        .rs1(rs1), .rs2(rs2), .funct3(funct3), .funct7(funct7));
    initial begin
        instruction = 32'h00500093;
        #10;
        if (opcode !== 7'b0010011 ||
            rd !== 5'd1 ||
            rs1 !== 5'd0 ||
            rs2 !== 5'd5 ||
            funct3 !== 3'b000 ||
            funct7 !== 7'b0000000)
            $fatal(1, "ADDI test failed");
        else
            $display("ADDI test passed");
        instruction = 32'h002081B3;
        #10;
        if (opcode !== 7'b0110011 ||
            rd !== 5'd3 ||
            rs1 !== 5'd1 ||
            rs2 !== 5'd2 ||
            funct3 !== 3'b000 ||
            funct7 !== 7'b0000000)
            $fatal(1, "ADD test failed");
        else
            $display("ADD test passed");
        instruction = 32'h40110233;
        #10;
        if (opcode !== 7'b0110011 ||
            rd !== 5'd4 ||
            rs1 !== 5'd2 ||
            rs2 !== 5'd1 ||
            funct3 !== 3'b000 ||
            funct7 !== 7'b0100000)
            $fatal(1, "SUB test failed");
        else
            $display("SUB test passed");
        $display("All instruction decoder tests passed");
        $finish;
    end
endmodule