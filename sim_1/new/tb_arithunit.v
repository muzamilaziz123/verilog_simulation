`timescale 1ns / 1ps
module tb_arithunit;
reg clk;
reg reset;
reg [15:0] data_1; 
reg [15:0] data_2;
reg [1:0] op_sel;
wire [15:0] data_out;

arithunit arithunit_instance (
    .clk        (clk),
    .reset      (reset),
    .data_1     (data_1),
    .data_2     (data_2),
    .op_sel     (op_sel),
    .data_out   (data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("arithunit_waveform.vcd");
    $dumpvars(1, arithunit_instance);
    
    // Initialize signals
    reset = 0;
    data_1 = 0;
    data_2 = 0;
    op_sel = 0;

    // Test case 1
    @(posedge clk);
    reset = 1;
    @(posedge clk);
    reset = 0;

    @(posedge clk);
    data_1 = {$random} % 10;
    data_2 = {$random} % 10;
    op_sel = 0;
    @(posedge clk);
    $display("Data 1 = %d, Data 2 = %d, Result = %d", data_1, data_2, data_out);

    // Test case 2
    @(posedge clk);
    reset = 1;
    @(posedge clk);
    reset = 0;

    @(posedge clk);
    data_1 = {$random} % 10;
    data_2 = {$random} % 10;
    op_sel = 1;
    @(posedge clk);
    $display("Data 1 = %d, Data 2 = %d, Result = %d", data_1, data_2, data_out);

    // Test case 3
    @(posedge clk);
    reset = 1;
    @(posedge clk);
    reset = 0;

    @(posedge clk);
    data_1 = {$random} % 10;
    data_2 = {$random} % 10;
    op_sel = 2;
    @(posedge clk);
    $display("Data 1 = %d, Data 2 = %d, Result = %d", data_1, data_2, data_out);

    // Test case 4
    @(posedge clk);
    reset = 1;
    @(posedge clk);
    reset = 0;

    @(posedge clk);
    data_1 = {$random} % 10;
    data_2 = {$random} % 10;
    op_sel = 3;
    @(posedge clk);
    $display("Data 1 = %d, Data 2 = %d, Result = %d", data_1, data_2, data_out);

    $finish;
end

endmodule
