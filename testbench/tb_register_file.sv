`timescale 1ns / 1ps

module tb_register_file;
    logic clk;
    logic reset;
    logic write_enable;
    logic [4:0] rs1, rs2, rd;
    logic [31:0] write_data;
    logic [31:0] read_data1, read_data2;
    register_file uut ( .clk(clk), .reset(reset), .write_enable(write_enable),
        .rs1(rs1), .rs2(rs2), .rd(rd),  .write_data(write_data),
        .read_data1(read_data1), .read_data2(read_data2));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        write_enable = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;
        @(posedge clk);
        #1;
        reset = 0;
        @(negedge clk);
        rd = 5;
        write_data = 32'd25;
        write_enable = 1;
        @(posedge clk);
        #1;
        write_enable = 0;
        rs1 = 5;
        #1;
        if (read_data1 !== 32'd25)
            $fatal(1, "Register write/read test failed");
        else
            $display("Register write/read test passed");

        @(negedge clk);
        rd = 10;
        write_data = 32'd50;
        write_enable = 1;
        @(posedge clk);
        #1;
        write_enable = 0;
        rs1 = 5;
        rs2 = 10;
        #1;
        if (read_data1 !== 32'd25 || read_data2 !== 32'd50)
            $fatal(1, "Dual read test failed");
        else
            $display("Dual read test passed");
        @(negedge clk);
        rd = 0;
        write_data = 32'd100;
        write_enable = 1;
        @(posedge clk);
        #1;
        write_enable = 0;
        rs1 = 0;
        #1;
        if (read_data1 !== 32'd0)
            $fatal(1, "x0 test failed");
        else
            $display("x0 protection test passed");
        $display("All register file tests passed");
        $finish;
    end
endmodule