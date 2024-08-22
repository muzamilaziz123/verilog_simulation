`timescale 1ns / 1ps
module tb_arithunit;
reg clk;
reg reset;
reg [15:0] data_1; 
reg [15:0] data_2 ;
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
    reset_sequence();
    data_sequence(0, 1);

    // Test case 2
    reset_sequence();
    data_sequence(1, 1);

    // Test case 3
    reset_sequence();
    data_sequence(2, 1);

    // Test case 4
    reset_sequence();
    data_sequence(3, 1);

    $finish;
end



endmodule
