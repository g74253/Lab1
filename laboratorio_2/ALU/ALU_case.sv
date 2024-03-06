module ALU_case #(parameter n=4)
					 (input logic [n-1:0] entrada1,  
					  input logic [n-1:0] entrada2, 
					  input logic [3:0] selector, 
					  output logic [3:0]resultado,
					  output logic carry, 
					  output logic cero,
					  output logic negativo,
					  output logic desbordamiento);
	
	logic [3:0] temp_resultado_suma;
	logic temp_carry_suma;
	logic temp_cero_suma;
	
	
	//Multiplicacion
	logic [3:0] temp_resultado_mult;
	logic temp_carry_mult;
	logic temp_negativo_mult;
	logic temp_cero_mult;
	logic temp_desbordamiento_mult;	

	suma_parametrizable suma (entrada1,entrada2,temp_resultado_suma,temp_carry_suma,temp_cero_suma);
	
	multiplicacion mult (entrada1, entrada2, temp_resultado_mult, temp_carry_mult, temp_negativo_mult, temp_cero_mult, temp_desbordamiento_mult); 
	
	always @(selector,entrada1,entrada2)
	begin
		case(selector)
			4'b0000://aqui va suma
				begin
				resultado = temp_resultado_suma;
				carry = temp_carry_suma;
				cero = temp_cero_suma;
				end
			4'b0001: //aqui va resta
				begin
				end
			4'b0010: //aqui va multiplicacion
				begin
				resultado = temp_resultado_mult;
				carry = temp_carry_mult;
				cero = temp_cero_mult;
				negativo = temp_negativo_mult;
				desbordamiento = temp_desbordamiento_mult;
				end
			4'b0011://aqui va divicion
				begin
				end
			4'b0100:// modulo
				begin
				end
			4'b0101:// and
				begin
				end
			4'b0110://or
				begin
				end
			4'b0111://xor
				begin
				end
			4'b1000://shift left logic
				begin
				end
			4'b1001:// shift right logic
				begin
				end
		endcase
	end
					  
endmodule