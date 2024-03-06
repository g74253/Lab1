
module shift_right_op #(
    parameter M = 4
)(
    input logic [M-1:0] entrada1,
    input logic [M-1:0] entrada2,
    output logic [M-1:0] resultado,
	  output logic cero
);

assign resultado = entrada1 >>> entrada2;
assign cero = ~(resultado || '0);
endmodule
