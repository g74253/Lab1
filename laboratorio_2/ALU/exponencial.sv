module exponencial #(
    parameter M = 4
)(
    input logic [M-1:0] entrada1,
    input logic [M-1:0] entrada2,
    output logic [M-1:0] resultado,
    output logic cero
	 
);

logic [M-1:0] temp_resultado;

always @* begin
    temp_resultado = 1; // Inicializa el resultado en 1
    
    // Utiliza un bucle para realizar la exponenciación
    for (int i = 0; i < entrada2; i++) begin
        temp_resultado *= entrada1; // Multiplica entrada1 por sí misma entrada2 veces
    end
end

assign resultado = temp_resultado;
assign cero = ~(resultado || '0);

endmodule
