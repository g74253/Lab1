module ALU_deco #(parameter n=4)
					 (input logic [n-1:0] entrada1,  
					  input logic [n-1:0] entrada2, 
					  input logic [3:0] selector, 
					  output logic [6:0]salida,
					  output logic carry, 
					  output logic cero);
					  
logic [3:0]resultado;
ALU_case calculadora(entrada1,entrada2,selector,resultado,carry,cero);

					  
endmodule