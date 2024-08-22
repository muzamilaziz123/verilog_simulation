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
    
    // Initial settings
    reset = 0;
    data_1 = 0;
    data_2 = 0;
    op_sel = 0;

    // Test Case 1
   #10;
    reset = 1;
    #10;
    reset = 0;
    #10;
    data_1 = 10;
    data_2 = 20;
    op_sel = 1;

    #10;
     reset = 1;
    #10;
    reset = 0;
    #10;
    data_1 = 30;
    data_2 = 40;
    op_sel = 2;

    #10;
     reset = 1;
    #10;
    reset = 0;
    #10;
    data_1 = 0;
    data_2 = 0;
    op_sel = 3;

    $finish;
end

endmodule





