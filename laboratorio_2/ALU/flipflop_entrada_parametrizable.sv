module flipflop_entradas_parametrizable #(parameter parametro = 4)
					( input logic [parametro-1:0] entrada1,  
					  input logic [parametro-1:0] entrada2, 
					  input logic [3:0] selector, 
					  input logic reset,
					  input logic clock, 
					  output logic [parametro-1:0] salida1,  
					  output logic [parametro-1:0] salida2, 
					  output logic [3:0]salida_selector);
genvar i;
generate
		for(i = 0; i < parametro; i = i+1)
			begin:flipflop
				flipflop_entradas memoria(entrada1[i],entrada2[i],selector[i],reset,clock,salida1[i],salida2[i],salida_selector[i]);
			end
endgenerate
endmodule