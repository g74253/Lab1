module flipflop_salidas( 
					  input logic display1,
					  input logic selectorLedDisplay,
					  input logic display2,
					  input logic carry, 
					  input logic cero,
					  input logic negativo,
					  input logic desbordamiento,
					  input logic reset,
					  input logic clock, 
					  output logic salida_display1,
					  output logic salida_selectorLedDisplay,
					  output logic salida_display2,
					  output logic salida_carry, 
					  output logic salida_cero,
					  output logic salida_negativo,
					  output logic salida_desbordamiento);
					  
always @ (posedge clock or posedge reset)	
begin
	if (reset)
		begin
			salida_display1=0;
			salida_selectorLedDisplay=0;
			salida_display2=0;
			salida_carry=0;
			salida_cero=0;
			salida_negativo=0;
			salida_desbordamiento=0;
		end
	else
	begin
		salida_display1 = display1;
		salida_selectorLedDisplay = selectorLedDisplay;
		salida_display2 = display2;
		salida_carry = carry;
		salida_cero = cero;
		salida_negativo = negativo;
		salida_desbordamiento = desbordamiento;
			
		end
end
endmodule				  
					  