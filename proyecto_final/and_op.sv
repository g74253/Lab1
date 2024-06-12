module and_op
	# (parameter M = 4)
	  (expresionA, expresionB, Resultado, cero);
  
	input  logic [M-1:0] expresionA;
	input  logic [M-1:0] expresionB;
	
	output logic [M-1:0] Resultado;

	output logic cero;
	
	always @ (expresionA or expresionB) begin
	
		for (int i = 0; i < $size(expresionA); i++) begin
		
			Resultado[i] = expresionA[i] && expresionB[i];
		
		end
		
		if (Resultado == 0) begin
			cero = 1;
		end else begin
			cero = 0;
		end
		
	end
		
endmodule
