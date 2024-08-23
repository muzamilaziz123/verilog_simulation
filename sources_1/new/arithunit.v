`timescale 1ns / 1ps
module arithunit(
input 				clk,
input 				reset,
input [15:0] 		data_1,
input [15:0] 		data_2,
input [1:0] 		op_sel,
output wrie b,
output reg [15:0] 	data_out 

);
initial begin
b = 0;  // This is not synthesizable
    #5 b = 1;  // Non-synthesizable dela
end
always@(*)
	begin
		if(reset)
			begin		
				data_out=0;
			
			end
		else
			begin
				case (op_sel) 	
					2'b00: data_out = data_1 + data_2;
					2'b01: data_out = data_1 - data_2;
					2'b10: data_out = data_1 * data_2;
					2'b11: data_out = data_1 & data_2;
					default: data_out = 16'b00;
				endcase
			end
	end

endmodule
