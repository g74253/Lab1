module pc_mem #(parameter n=8)(input logic clk,
										input logic rst,
										input logic [n-1:0]pcnext,
										output logic [n-1:0]pc);
										
always_ff @(posedge clk, posedge rst)
	if (rst) pc = 0;
	else pc = pcnext;
	
endmodule