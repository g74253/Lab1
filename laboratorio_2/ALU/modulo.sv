module modulo
	# (parameter M = 4)
	  (A, B, R, C, N, V, Z);

	input  logic [M-1:0] A;
	input  logic [M-1:0] B;
	
	output logic [M-1:0] R;
	output				   C;
	output					N;
	output					V;
	output					Z;
	
	always @ (A or B) begin
		
			R = A % B;
			
			Z = ~(R || '0);
		
			
	end		

endmodule
