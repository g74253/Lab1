module resta 
	#(parameter M = 4)
	 (input logic [M - 1 : 0] A,
	  input logic [M - 1 : 0] B,
	  output logic [M - 1 : 0] R,
	  output				   C,
	  output					N,
	  output					V,
	  output					Z);
	  
	logic [M : 0] cins;
	
	assign cins[0] = 1'b1;

	genvar i;
	
	assign N = B>A;
	
	assign Z = B==A;
	
	
	generate
	

		for (i = 0; i < M; i += 1) begin : GenSumadores

			suma sumador (.entrada1(A[i]), .entrada2(~B[i] ), .carry_in(cins[i]), .carry_out(cins[i + 1]),
									.resultado(R[i]));

		end
		
	endgenerate
	
	assign C = cins[M];
	


endmodule
