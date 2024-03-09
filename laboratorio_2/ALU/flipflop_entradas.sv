module flipflop_entradas( input logic entrada1,  
					  input logic entrada2, 
					  input logic selector, 
					  input logic reset,
					  input logic clock, 
					  output logic salida1,  
					  output logic salida2, 
					  output logic salida_selector);
					  
always @ (posedge clock or posedge reset)	
begin
	if (reset)
		begin
			salida1 = 0;
			salida2 = 0;
			salida_selector = 0;
		end
	else
		begin
			salida1 = entrada1;
			salida2 = entrada2;
			salida_selector = selector;
		end
end
endmodule				  
					  