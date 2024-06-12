module ALU_case #(parameter n=32)
					 (input logic [n-1:0] entrada1,  
					  input logic [n-1:0] entrada2, 
					  input logic [1:0] alucontrol, 
					  output logic [n-1:0]resultado,
					  output logic carry, 
					  output logic cero,
					  output logic negativo,
					  output logic desbordamiento);
	
	logic [n-1:0] temp_resultado_suma;
	logic temp_carry_suma;
	logic temp_cero_suma;
	
	//Resta
	logic [n-1:0] temp_resultado_resta;
	logic temp_carry_resta;
	logic temp_negativo_resta;
	logic temp_cero_resta;
	logic temp_desbordamiento_resta;
	
	//Operacion AND
	logic [n-1:0] temp_resultado_And;
	logic temp_cero_And;
	
	//Operacion OR
	logic [n-1:0] temp_resultado_Or;
	logic temp_cero_Or;
	
	
	
	suma_parametrizable #(n) suma (entrada1,entrada2,temp_resultado_suma,temp_carry_suma,temp_cero_suma);
	resta #(n) rest (entrada1, entrada2, temp_resultado_resta, temp_carry_resta, temp_negativo_resta, temp_desbordamiento_resta, temp_cero_resta);

	
	or_op #(n) or_m(entrada1, entrada2,temp_resultado_Or,temp_cero_Or);
	and_op #(n) and_m(entrada1, entrada2,temp_resultado_And,temp_cero_And);
	
	
	always @(alucontrol,entrada1,entrada2)
	begin
		case(alucontrol)
			2'b00://aqui va suma
				begin
					resultado = temp_resultado_suma;
					carry = temp_carry_suma;
					cero = temp_cero_suma;
				end
			2'b01: //aqui va resta
				begin
				resultado = temp_resultado_resta;
				carry = temp_carry_resta;
				cero = temp_cero_resta;
				negativo = temp_negativo_resta;
				desbordamiento = temp_desbordamiento_resta;
				end
			
			2'b10:// and
				begin
					resultado=temp_resultado_And;
					cero= temp_cero_And;
					carry=0;
					negativo=0;
					desbordamiento=0;
				end
			2'b11://or
				begin
				
				resultado=temp_resultado_Or;
				cero= temp_cero_Or;
				carry=0;
				negativo=0;
				desbordamiento=0;
				
				end

		endcase
	end
					  
endmodule