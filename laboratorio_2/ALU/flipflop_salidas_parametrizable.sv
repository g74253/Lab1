module flipflop_salidas_parametrizable #(parameter parametro = 4)
					( input logic [6:0]display1,
					  input logic [3:0]selectorLedDisplay,
					  input logic [6:0]display2,
					  input logic carry, 
					  input logic cero,
					  input logic negativo,
					  input logic desbordamiento,
					  input logic reset,
					  input logic clock, 
					  output logic [6:0]salida_display1,
					  output logic [3:0]salida_selectorLedDisplay,
					  output logic [6:0]salida_display2,
					  output logic salida_carry, 
					  output logic salida_cero,
					  output logic salida_negativo,
					  output logic salida_desbordamiento);
genvar i;
generate
		for(i = 0; i < parametro; i = i+1)
			begin:flipflop
				flipflop_entradas memoria(display1[i],
											selectorLedDisplay[i],
											display2[i],
											carry,
											cero,
											negativo,
											desbordamiento,
											reset,
											clock,
											salida_display1[i],
											salida_selectorLedDisplay[i],
											salida_display2[i],
											salida_carry,
											salida_cero, 
											salida_negativo,
											salida_desbordamiento);
			end
endgenerate
endmodule