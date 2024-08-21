`timescale 1ns / 1ps
module tb_arithunit;
reg clk;
reg reset;
reg [15:0] data_1; 
reg [15:0] data_2 ;
reg [1:0] op_sel;
wire [15:0] data_out;




arithunit arithunit_instance(
.clk  		(clk),
.reset 		(reset),
.data_1 	(data_1),
.data_2 	(data_2),
.op_sel		(op_sel),
.data_out 	(data_out)
);

initial
begin
	clk=0;
	forever #5 clk =~clk;
end

initial
begin
	$dumpfile("arithunit_waveform.vcd");
	$dumpvars(1,arithunit_instance);
	
	data_1=0;
	data_2=0;
	reset=0;
	op_sel=0;
repeat (3)
begin
	@(posedge clk)
		reset<= #1 1;
	@(posedge clk)
		reset<= #1 0;
	@(posedge clk)
		#1 data_1 =0+{$random}%(10);
		 data_2 = 0+{$random}%(10);
		 op_sel =0;
	@(posedge clk);
		$display ("Data 1 = %d",data_1);
		$display ("Data 2 = %d",data_2);
		$display ("Result = %d", data_out);
	
	@(posedge clk)
		reset<= #1 1;
	@(posedge clk)
		 reset<= #1 0;
	@(posedge clk)
		#1 data_1 =0+{$random}%(10);
		 data_2 = 0+{$random}%(10);
		 op_sel =1;
	@(posedge clk);
		$display ("Data 1 = %d",data_1);
		$display ("Data 2 = %d",data_2);
		$display ("Result = %d", data_out);		
	@(posedge clk)
		reset<= #1 1;
	@(posedge clk)
		 reset<= #1 0;
	@(posedge clk)		
		#1 data_1 =0+{$random}%(10);
		 data_2 = 0+{$random}%(10);
		 op_sel =2;
	@(posedge clk);
	
		$display ("Data 1 = %d",data_1);
		$display ("Data 2 = %d",data_2);
		$display ("Result = %d", data_out);
	@(posedge clk)
		reset<= #1 1;
	@(posedge clk)
		 reset<= #1 0;
	@(posedge clk)
		#1 data_1 =0+{$random}%(10);
		 data_2 = 0+{$random}%(10);
		 op_sel =3;	
	@(posedge clk);

		$display ("Data 1 = %d",data_1);
		$display ("Data 2 = %d",data_2);	 	
		$display ("Result = %d", data_out);
	
end
	$finish;		
end

endmodule
