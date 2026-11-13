
module instruction_memory (input logic [31:0] address, output logic [31:0] instruction);
    always_comb begin
        case (address)
            32'h00000000: instruction = 32'h00500093;
            32'h00000004: instruction = 32'h00A00113;
            32'h00000008: instruction = 32'h002081B3;
            32'h0000000C: instruction = 32'h40110233;
            32'h00000010: instruction = 32'h00302023;
            32'h00000014: instruction = 32'h00002283;
            default: instruction = 32'h00000013;
        endcase
    end
endmodule
