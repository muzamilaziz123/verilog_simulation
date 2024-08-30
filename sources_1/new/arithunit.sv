`timescale 1ns / 1ps

module arithunit(
    input  logic             clk,
    input  logic             reset,
    input  logic [15:0]      data_1,
    input  logic [15:0]      data_2,
    input  logic [1:0]       op_sel,
    output logic [15:0]      data_out
);

always_comb begin
    if (reset) begin
        data_out = 0;
    end else begin
        case (op_sel)
            2'b00: data_out = data_1 + data_2;
            2'b01: data_out = data_1 - data_2;
            2'b10: data_out = data_1 * data_2;
            2'b11: data_out = data_1 & data_2;
            default: data_out = 16'b0;
        endcase
    end
end

endmodule

