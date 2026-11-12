
module tb_instruction_memory;

    logic [31:0] address;
    logic [31:0] instruction;

    // Instantiate Instruction Memory
    instruction_memory uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin

        // Test 1: Address 0x00
        address = 32'h00000000;
        #10;
        $display("Address: %h | Instruction: %h",
                  address, instruction);
        if (instruction !== 32'h00500093)
            $fatal(1, "TEST 1 FAILED");

        // Test 2: Address 0x04
        address = 32'h00000004;
        #10;
        $display("Address: %h | Instruction: %h",
                  address, instruction);
        if (instruction !== 32'h00A00113)
            $fatal(1, "TEST 2 FAILED");

        // Test 3: Address 0x08
        address = 32'h00000008;
        #10;
        $display("Address: %h | Instruction: %h",
                  address, instruction);
        if (instruction !== 32'h002081B3)
            $fatal(1, "TEST 3 FAILED");

        // Test 4: Address 0x0C
        address = 32'h0000000C;
        #10;
        $display("Address: %h | Instruction: %h",
                  address, instruction);
        if (instruction !== 32'h40110233)
            $fatal(1, "TEST 4 FAILED");

        // Test 5: Invalid address
        address = 32'h00000010;
        #10;
        $display("Address: %h | Instruction: %h",
                  address, instruction);
        if (instruction !== 32'h00000013)
            $fatal(1, "TEST 5 FAILED");

        $display("--------------------------------");
        $display("ALL INSTRUCTION MEMORY TESTS PASSED");
        $display("--------------------------------");

        $finish;

    end

endmodule
