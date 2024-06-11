module suma_parametrizable
	# (parameter n = 4)
	  (input  logic [n-1:0] entrada1,
	  input  logic [n-1:0] entrada2, 
	  output logic [n-1:0] resultado, 
	  output logic carry, 
	  output logic cero);

    wire [n-1:0] temp_carry;
    genvar i;
 
    generate
	 
      for (i = 0; i < n; i = i + 1) begin: generate_suma
		
        if (i == 0) 
          suma sum_nc (entrada1[i], entrada2[i], 0, resultado[i], temp_carry[i]); //nc=no carry
        else 
          suma sum_c (entrada1[i], entrada2[i], temp_carry[i-1], resultado[i], temp_carry[i]); //c=carry
			 
      end
 
      assign carry = temp_carry[n-1];
		
		assign cero = ~(resultado || '0) && ~carry;
		  
    endgenerate
	 
endmodule
