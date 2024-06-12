module control_deco_PC_logic(input logic [3:0]rd ,
									  input logic branch,
									  input logic regw,
									  output logic pcs);
									  
assign pcs = ((rd == 4'b1111) & regw)|branch;

endmodule

