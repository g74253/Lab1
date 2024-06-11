module mux_parametrizable #(parameter n = 8)(input logic [n-1:0] input1,
														  input logic [n-1:0] input2,
														  input logic select,
														  output logic [n-1:0] final_output);
														  
	assign final_output = select ? input1 : input2;
	
endmodule

