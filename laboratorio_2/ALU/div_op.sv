module div_op
	#(parameter M = 4)(
	  input 	logic [2*M-1:0] expresionA,
	  input 	logic [M-1:0] 	 expresionB,
	  
	  output logic [M-1:0] 	 resultado,
	  output				   	 carry,
	  output						 cero);
	  
  logic [2*M-1:0] temp;
  logic [M-1:0] shift;
  logic [M-1:0] 	 R;
  assign temp = {expresionA, {M{1'b0}}};
  
  always @(*) begin
    shift = 0;
    R = 0;
    for (int i = M-1; i >= 0; i--) begin
      shift = {shift[0], temp[i+M]};
      if (shift >= expresionB) begin
        shift = shift - expresionB;
        R[i] = 1;
      end
    end
    resultado = shift;
	 
	 cero = ~(R || '0) && ~carry;
	 
  end
endmodule
