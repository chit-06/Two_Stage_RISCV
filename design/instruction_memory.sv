
module instruction_memory (input logic [31:0] address, output logic [31:0] instruction);
    always_comb begin
        case (address)
            32'h00000000: instruction = 32'h00500093;
            32'h00000004: instruction = 32'h00A00113;
            32'h00000008: instruction = 32'h002081B3;
            32'h0000000C: instruction = 32'h40110233;
            32'h00000010: instruction = 32'h00302023;
            32'h00000014: instruction = 32'h00002283;
            32'h00000018: instruction = 32'h00108463;
            32'h0000001C: instruction = 32'h06300313;
            32'h00000020: instruction = 32'h00700393;
            32'h00000024: instruction = 32'h00209463;
            32'h00000028: instruction = 32'h06300493;
            32'h0000002C: instruction = 32'h00800413;
            32'h00000030: instruction = 32'h00300513;
            32'h00000034: instruction = 32'h00450593;
            32'h00000038: instruction = 32'h00A58633;
            default: instruction = 32'h00000013;
        endcase
    end
endmodule
