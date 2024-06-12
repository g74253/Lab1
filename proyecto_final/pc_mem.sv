module pc_mem #(
    parameter n = 8 // Parámetro para especificar el tamaño del contador de programa
)(
    input logic clk,       // Señal de reloj
    input logic rst,       // Señal de reset
    input logic [n-1:0] pcnext, // Próxima dirección del contador de programa
    output logic [n-1:0] pc     // Dirección actual del contador de programa
);

    always_ff @(posedge clk, posedge rst) begin
        if (rst)            // Si se activa la señal de reset
            pc <= 0;        // Restablecer el contador de programa a 0
        else                // Si no hay reset
            pc <= pcnext;   // Asignar la próxima dirección del contador de programa a la salida
    end

endmodule
