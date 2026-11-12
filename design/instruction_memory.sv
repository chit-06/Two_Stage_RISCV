
module instruction_memory (
    input  logic [31:0] address,
    output logic [31:0] instruction
);

    // Combinational instruction memory
    always_comb begin

        case (address)

            32'h00000000: instruction = 32'h00500093; // ADDI x1, x0, 5
            32'h00000004: instruction = 32'h00A00113; // ADDI x2, x0, 10
            32'h00000008: instruction = 32'h002081B3; // ADD  x3, x1, x2
            32'h0000000C: instruction = 32'h40110233; // SUB  x4, x2, x1

            // Default instruction: NOP (ADDI x0, x0, 0)
            default: instruction = 32'h00000013;

        endcase

    end

endmodule
