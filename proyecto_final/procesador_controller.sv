module procesador_controller (input logic clk,
						 input logic rst,
						 input logic wren_b,
						 output logic Hsynq,
					  	 output logic Vsynq, blank, sync,
						 output logic [7:0] Green,
						 output logic [7:0] Red,
						  output logic [7:0]q_b,
						 output logic [7:0] Blue,
						 output logic clk_vga);

						 
						 

logic [31:0]address;

procesador pro (.clk(clk), 
					.rst(rst),
					.wren_b(wren_b),
					.address(address),
					.q_b(q_b));
	
	
vga_controller vga(
	.clk(clk),
	.rst(rst),
	.q_b(q_b),
	.Hsynq(Hsynq),
	.Vsynq(Vsynq),
	.blank(blank),
	.sync(sync),
	.Red(Red),
	.Green(Green),
	.Blue(Blue), 
	.clk_vga(clk_vga),
	.address(address));
										
endmodule									