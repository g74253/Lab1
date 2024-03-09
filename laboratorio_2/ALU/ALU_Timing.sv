module ALU_Timing #(parameter n=32)(
					  input logic clock,
					  input logic [n-1:0] entrada1,  
					  input logic [n-1:0] entrada2, 
					  input logic [3:0] selector, 
					  output logic [6:0]display1,
					  output logic [3:0] selectorLedDisplay,
					  output logic [6:0]display2,
					  output logic carry, 
					  output logic cero,
					  output logic negativo,
					  output logic desbordamiento

);



					  
logic [6:0]salida_display1;
logic [3:0]salida_selectorLedDisplay;
logic [6:0]salida_display2;
logic salida_carry;
logic salida_cero;
logic salida_negativo;
logic salida_desbordamiento;


logic [n-1:0] salida1;
logic [n-1:0] salida2; 
logic [3:0]salida_selector;	
			  
					  

flipflop_entradas_parametrizable flip_entrada(entrada1,entrada2,selector,reset,clock,salida1,salida2,salida_selector) ;
					 		 					 
					 


ALU_deco #(4) ALU ( 	  
					  salida1,  
					  salida2, 
					  salida_selector, 
					  display1,
					  selectorLedDisplay,
					  display2,
					  carry, 
					  cero,
					  negativo,
					  desbordamiento
					  );

	
flipflop_salidas_parametrizable flip_salida(
													display1,
													selectorLedDisplay,
													display2,
													carry,
													cero,
													negativo,
													desbordamiento,
													reset,
													clock,
													salida_display1,
													salida_selectorLedDisplay,
													salida_display2,
													salida_carry, 
													salida_cero,
													salida_negativo,
													salida_desbordamiento				
														);
															
					 
					 
					 
endmodule