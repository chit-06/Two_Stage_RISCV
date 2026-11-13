`timescale 1ns / 1ps

module tb_data_memory;
    logic clk;
    logic mem_read;
    logic mem_write;
    logic [31:0] address;
    logic [31:0] write_data;
    logic [31:0] read_data;
    data_memory uut ( .clk(clk), .mem_read(mem_read), .mem_write(mem_write),
        .address(address), .write_data(write_data), .read_data(read_data));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        mem_read = 0;
        mem_write = 0;
        address = 0;
        write_data = 0;
        @(negedge clk);
        address = 32'h00000004;
        write_data = 32'd25;
        mem_write = 1;
        @(posedge clk);
        #1;
        mem_write = 0;
        mem_read = 1;
        #1;
        if (read_data !== 32'd25)
            $fatal(1, "Memory write/read test failed");
        else
            $display("Memory write/read test passed");
        @(negedge clk);
        address = 32'h00000008;
        write_data = 32'd50;
        mem_write = 1;
        mem_read = 0;
        @(posedge clk);
        #1;
        mem_write = 0;
        mem_read = 1;
        #1;
        if (read_data !== 32'd50)
            $fatal(1, "Second memory location test failed");
        else
            $display("Second memory location test passed");
        address = 32'h00000004;
        #1;
        if (read_data !== 32'd25)
            $fatal(1, "Memory retention test failed");
        else
            $display("Memory retention test passed");
        mem_read = 0;
        #1;
        if (read_data !== 32'b0)
            $fatal(1, "Read disable test failed");
        else
            $display("Read disable test passed");
        $display("All data memory tests passed");
        $finish;
    end
endmodule