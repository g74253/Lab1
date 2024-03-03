module suma(input entrada1, entrada2, carry_in, output resultado, carry_out);

	assign resultado = (entrada1 ^ entrada2) ^ carry_in;
	assign carry_out = (entrada1 & entrada2) || (carry_in & (entrada1 ^ entrada2));

endmodule