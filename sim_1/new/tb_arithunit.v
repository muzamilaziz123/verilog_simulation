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

// Task to generate a single clock cycle event
task wait_for_clock;
    begin
        #time_ns;
    end
endtask

// Task to perform a reset sequence
task reset_sequence;
    begin
        wait_for_clock;
        reset <= 1;
        wait_for_clock;
        reset <= 0;
    end
endtask

// Task to perform a data sequence with the given operation
task data_sequence(input [1:0] op, input integer cycles);
    begin
        repeat (cycles) wait_for_clock;
        #1 data_1 = {$random} % 10;
        data_2 = {$random} % 10;
        op_sel = op;
        wait_for_clock;
        $display("Data 1 = %d", data_1);
        $display("Data 2 = %d", data_2);
        $display("Result = %d", data_out);
    end
endtask

initial begin
    $dumpfile("arithunit_waveform.vcd");
    $dumpvars(1, arithunit_instance);
    
    // Initial settings
    reset = 0;
    data_1 = 0;
    data_2 = 0;
    op_sel = 0;

    // Test Case 1
    reset_sequence;
    data_sequence(2'b00, 1);

    // Test Case 2
    reset_sequence;
    data_sequence(2'b01, 2);

    // Test Case 3
    reset_sequence;
    data_sequence(2'b10, 3);

    // Test Case 4
    reset_sequence;
    data_sequence(2'b11, 4);

    $finish;
end

endmodule
