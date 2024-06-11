module control_deco_PC_logic(input logic [3:0]rd ,
									  input logic branch,
									  input logic regw,
									  output pcs);
									  
assign pcs = ((rd == 15) & regw)|branch;

endmodule

