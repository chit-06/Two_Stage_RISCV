module alu ( input logic [31:0] operand_a, input logic [31:0] operand_b,
    input logic [3:0] alu_control, output logic [31:0] result, output logic zero);
    always_comb begin
        case (alu_control)
            4'b0000: result = operand_a + operand_b;
            4'b0001: result = operand_a - operand_b;
            4'b0010: result = operand_a & operand_b;
            4'b0011: result = operand_a | operand_b;
            4'b0100: result = operand_a ^ operand_b;
            4'b0101: result = ($signed(operand_a) < $signed(operand_b)) ? 32'd1 : 32'd0;
            default: result = 32'b0;
        endcase
        zero = (result == 32'b0);
    end
endmodule