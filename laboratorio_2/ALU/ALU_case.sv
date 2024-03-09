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
	
	//Resta
	logic [3:0] temp_resultado_resta;
	logic temp_carry_resta;
	logic temp_negativo_resta;
	logic temp_cero_resta;
	logic temp_desbordamiento_resta;
	
	//Multiplicacion
	logic [3:0] temp_resultado_mult;
	logic temp_carry_mult;
	logic temp_negativo_mult;
	logic temp_cero_mult;
	logic temp_desbordamiento_mult;	
	
	//Modulo
	logic [3:0] temp_resultado_mod;
	logic temp_carry_mod;
	logic temp_negativo_mod;
	logic temp_cero_mod;
	logic temp_desbordamiento_mod;	
	
	//Operacion AND
	logic [3:0] temp_resultado_And;
	logic temp_cero_And;
	
	//Operacion XOR
	logic [3:0] temp_resultado_Xor;
	logic temp_cero_Xor;
	
	//Operacion OR
	logic [3:0] temp_resultado_Or;
	logic temp_cero_Or;
	

	//division
	logic [3:0] temp_resultado_div;
	logic [3:0] temp_residuo_div;
	logic temp_carry_div;
	logic temp_negativo_div;
	logic temp_cero_div;
	logic temp_desbordamiento_div;
	
	//shiftLeft
	logic [3:0] temp_resultado_shiftLeft;
	logic [3:0] temp_residuo_shiftLeft;
	logic temp_cero_shiftLeft;

	//shiftRight
	logic [3:0] temp_resultado_shiftRight;
	logic [3:0] temp_residuo_shiftRight;
	logic temp_cero_shiftRight;
	
	//exponencial
	logic [3:0] temp_resultado_exponencial;
	logic temp_cero_exponencial;
	logic temp_desbordamiento_exponencial;
	logic temp_carry_exponencial;
	
	suma_parametrizable suma (entrada1,entrada2,temp_resultado_suma,temp_carry_suma,temp_cero_suma);
	resta rest (entrada1, entrada2, temp_resultado_resta, temp_carry_resta, temp_negativo_resta, temp_desbordamiento_resta, temp_cero_resta);
	mult multiplicacion  (entrada1, entrada2, temp_resultado_mult, temp_carry_mult, temp_negativo_mult, temp_desbordamiento_mult, temp_cero_mult); 
	modulo mod  (entrada1, entrada2, temp_resultado_mod, temp_carry_mod, temp_negativo_mod, temp_desbordamiento_mod, temp_cero_mod);
	div_op division  (entrada1, entrada2, temp_resultado_div, temp_residuo_div, temp_carry_div, temp_negativo_div, temp_desbordamiento_div, temp_cero_div);
	exponencial expo(entrada1, entrada2, temp_resultado_exponencial,temp_cero_exponencial);
	

	
	
	xor_op xor_m (entrada1, entrada2,temp_resultado_Xor,temp_cero_Xor);
	or_op or_m(entrada1, entrada2,temp_resultado_Or,temp_cero_Or);
	and_op and_m(entrada1, entrada2,temp_resultado_And,temp_cero_And);
	shift_left_op shiftLeft(entrada1, entrada2,temp_resultado_shiftLeft);
	shift_right_op shiftRight(entrada1, entrada2,temp_resultado_shiftRight);
	

	
	always @(selector,entrada1,entrada2)
	begin
		case(selector)
			4'b0001://aqui va suma
				begin
					resultado = temp_resultado_suma;
					carry = temp_carry_suma;
					cero = temp_cero_suma;
				end
			4'b0010: //aqui va resta
				begin
				resultado = temp_resultado_resta;
				carry = temp_carry_resta;
				cero = temp_cero_resta;
				negativo = temp_negativo_resta;
				desbordamiento = temp_desbordamiento_resta;
				end
			4'b0011: //aqui va multiplicacion
				begin
					resultado = temp_resultado_mult;
					carry = temp_carry_mult;
					cero = temp_cero_mult;
					negativo = temp_negativo_mult;
					desbordamiento = temp_desbordamiento_mult;
				end
			4'b0100://aqui va division
				begin
				resultado = temp_resultado_div;
				carry = temp_carry_div;
				cero = temp_cero_div;
				negativo = temp_negativo_div;
				desbordamiento = temp_desbordamiento_div;
				end
			4'b0101:// modulo
				begin
					resultado = temp_resultado_mod;
					carry = temp_carry_mod;
					cero = temp_cero_mod;
					negativo = 0;
					desbordamiento = temp_desbordamiento_mod;
				end
			4'b0110:// and
				begin
					resultado=temp_resultado_And;
					cero= temp_cero_And;
					carry=0;
					negativo=0;
					desbordamiento=0;
				end
			4'b0111://or
				begin
				
				resultado=temp_resultado_Or;
				cero= temp_cero_Or;
				carry=0;
				negativo=0;
				desbordamiento=0;
				
				end
			4'b1000://xor
				begin
					resultado=temp_resultado_Xor;
					cero= temp_cero_Xor;
					carry=0;
					negativo=0;
					desbordamiento=0;				
				end
			4'b1001://shift left logic
				begin
					resultado=temp_resultado_shiftLeft;
					cero= temp_cero_shiftLeft;
					carry=0;
					negativo=0;
					desbordamiento=0;	
					
					
				
				end
			4'b1010:// shift right logic
				begin
				
					resultado=temp_resultado_shiftRight;
					cero= temp_cero_shiftRight;
					carry=0;
					negativo=0;
					desbordamiento=0;	
				
				end
			4'b1011: // exponencial 
				begin
				
								
					resultado=temp_resultado_exponencial;
					cero= temp_cero_exponencial;
					carry=temp_carry_exponencial;
					negativo=0;
					desbordamiento=0;	
				
				end
		endcase
	end
					  
endmodule