module and_op
	# (parameter M = 4)
	  (expresionA, expresionB, Resultado, cero);
  
	input  logic [M-1:0] expresionA;
	input  logic [M-1:0] expresionB;
	
	output logic [M-1:0] Resultado;

	output					cero;
	
	always @ (expresionA or expresionB) begin
	
		for (int i = 0; i < $size(expresionA); i++) begin
		
			Resultado[i] = expresionA[i] && expresionB[i];
		
		end
		
		cero = ~(Resultado || '0);
		
	end
		
endmodule
