module xor_op
	# (parameter M = 4)
	  (expresionA, expresionB, resultado, cero);
  
	input  logic [M-1:0] expresionA;
	input  logic [M-1:0] expresionB;
	
	output logic [M-1:0] resultado;
	output					cero;
	
	always @ (expresionA or expresionB) begin
	
		for (int i = 0; i < $size(expresionA); i++) begin
		
				resultado[i] = expresionA[i] ^ expresionB[i];
		end
		
		cero = ~(resultado || '0);
		
	end
		
endmodule