module control_unit ( input logic [6:0] opcode, input logic [2:0] funct3, input logic [6:0] funct7,
    output logic reg_write, output logic mem_read, output logic mem_write,
    output logic mem_to_reg, output logic alu_src, output logic branch,
    output logic branch_ne, output logic lui, output logic [3:0] alu_control,
    output logic illegal);
    always_comb begin
        reg_write = 0;
        mem_read = 0;
        mem_write = 0;
        mem_to_reg = 0;
        alu_src = 0;
        branch = 0;
        branch_ne = 0;
        lui = 0;
        alu_control = 4'b0000;
        illegal = 1;
        case (opcode)
            7'b0110011: begin
                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'b0000000) begin
                            alu_control = 4'b0000;
                            illegal = 0;
                        end
                        else if (funct7 == 7'b0100000) begin
                            alu_control = 4'b0001;
                            illegal = 0;
                        end
                    end
                    3'b111: begin
                        if (funct7 == 7'b0000000) begin
                            alu_control = 4'b0010;
                            illegal = 0;
                        end
                    end
                    3'b110: begin
                        if (funct7 == 7'b0000000) begin
                            alu_control = 4'b0011;
                            illegal = 0;
                        end
                    end
                    3'b100: begin
                        if (funct7 == 7'b0000000) begin
                            alu_control = 4'b0100;
                            illegal = 0;
                        end
                    end
                    3'b010: begin
                        if (funct7 == 7'b0000000) begin
                            alu_control = 4'b0101;
                            illegal = 0;
                        end
                    end
                    default: illegal = 1;
                endcase

                if (!illegal)
                    reg_write = 1;
            end
            7'b0010011: begin
                if (funct3 == 3'b000) begin
                    reg_write = 1;
                    alu_src = 1;
                    alu_control = 4'b0000;
                    illegal = 0;
                end
            end
            7'b0000011: begin
                if (funct3 == 3'b010) begin
                    reg_write = 1;
                    mem_read = 1;
                    mem_to_reg = 1;
                    alu_src = 1;
                    alu_control = 4'b0000;
                    illegal = 0;
                end
            end

            7'b0100011: begin
                if (funct3 == 3'b010) begin
                    mem_write = 1;
                    alu_src = 1;
                    alu_control = 4'b0000;
                    illegal = 0;
                end
            end
            7'b1100011: begin
                if (funct3 == 3'b000 || funct3 == 3'b001) begin
                    branch = 1;
                    branch_ne = (funct3 == 3'b001);
                    alu_control = 4'b0001;
                    illegal = 0;
                end
            end
            7'b0110111: begin
                reg_write = 1;
                alu_src = 1;
                lui = 1;
                alu_control = 4'b0000;
                illegal = 0;
            end
            default: illegal = 1;
        endcase
    end
endmodule