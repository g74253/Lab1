module ALU_deco #(parameter n=4)
					 ( 
					  
					  input logic [n-1:0] entrada1,  
					  input logic [n-1:0] entrada2, 
					  input logic [3:0] selector, 
					  output logic [6:0]display1,
					  output logic [3:0] selectorLedDisplay,
					  
					  output logic [6:0]display2,
					  output logic carry, 
					  output logic cero);
					  
	logic [3:0]resultado;
	
	
	assign selectorLedDisplay[0]= ~selector[0];
	assign selectorLedDisplay[1]= ~selector[1];
	assign selectorLedDisplay[2]= ~selector[2];
	assign selectorLedDisplay[3]= ~selector[3];
	ALU_case calculadora(.entrada1(entrada1),.entrada2(entrada2),.selector(selectorLedDisplay),.resultado(resultado),.carry(carry),.cero(cero));
	
	decodificador d1(
		.c(display1), 
		.e(resultado)
		);
	decodificador d2(
		.c(display2), 
		.e(4'b0000)
		);

endmodule