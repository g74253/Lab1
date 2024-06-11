module or_op #(parameter M = 4) (
    input  logic [M-1:0] expresionA,
    input  logic [M-1:0] expresionB,
    output logic [M-1:0] resultado,
    output logic          cero
);

always_comb begin
    for (int i = 0; i < M; i++) begin
        resultado[i] = expresionA[i] || expresionB[i];
    end
    cero = |resultado; // Verifica si resultado contiene solo ceros
end

endmodule
