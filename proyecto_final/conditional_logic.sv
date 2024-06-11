module conditional_logic(input logic [3:0]cond,
								 input logic [3:0]aluflags,
								 input logic clk,
								 input logic [1:0]flagw,
								 input logic pcs,
								 input logic regw,
								 input logic memw,
								 output logic pcsrc,
								 output logic regwrite,
								 output logic memwrite);
								 
	logic [1:0]flags32;
	logic [1:0]flags10;
	logic condex;
	logic [1:0]flagwrite; 	
	condition_check cc (.cond(cond),
						  .flags32(flags32),
						  .flags10(flags10),
						  .condex(condex));
						  
assign pcsrc = pcs & condex;
assign regwrite = regw & condex;
assign memwrite = memw & condex;
assign flagwrite = flagw && condex;

always @ (posedge clk) begin

	if (flagwrite[1] ==1) begin
		flags32[0]= aluflags[2];
		flags32[1]= aluflags[3];
	end
	
	if (flagwrite[0] ==1) begin
		flags10[0]= aluflags[0];
		flags10[1]= aluflags[1];
	end
end
								 
endmodule