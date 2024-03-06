module exponencial #(
    parameter M = 4
)(
    input logic [M-1:0] entrada1,
    input logic [M-1:0] entrada2,
    input logic carry_in,
    output logic [M-1:0] resultado,

);

logic [M-1:0] temp_resultado;
logic temp_carry;

always @* begin
    temp_resultado = entrada1 ** entrada2; // Calcula la exponenciación de entrada1 elevado a la entrada2
  
end

assign resultado = temp_resultado;


endmodule
