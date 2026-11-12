
module tb_instruction_memory;
    logic [31:0] address;
    logic [31:0] instruction;
    instruction_memory uut (.address(address), .instruction(instruction));
    initial begin
        address = 32'h00000000;
        #10;
        $display("Address: %h | Instruction: %h", address, instruction);
        if (instruction !== 32'h00500093)
            $fatal(1, "Test 1 failed");
        address = 32'h00000004;
        #10;
        $display("Address: %h | Instruction: %h", address, instruction);
        if (instruction !== 32'h00A00113)
            $fatal(1, "Test 2 failed");
        address = 32'h00000008;
        #10;
        $display("Address: %h | Instruction: %h", address, instruction);
        if (instruction !== 32'h002081B3)
            $fatal(1, "Test 3 failed");
        address = 32'h0000000C;
        #10;
        $display("Address: %h | Instruction: %h", address, instruction);
        if (instruction !== 32'h40110233)
            $fatal(1, "Test 4 failed");
        address = 32'h00000010;
        #10;
        $display("Address: %h | Instruction: %h", address, instruction);
        if (instruction !== 32'h00000013)
            $fatal(1, "Test 5 failed");
        $display("All instruction memory tests passed");
        $finish;
    end
endmodule
