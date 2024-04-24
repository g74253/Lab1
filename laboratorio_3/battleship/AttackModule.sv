module AttackModule(
    input logic clk,
    input logic rst,
    input logic [4:0] row,
    input logic [4:0] col,
    inout int matrix [4:0][4:0], // Matriz que se ataca (modificada directamente)
    input logic player, // Indicador de jugador (1 o 2)
    output logic impact // Indica si hubo impacto
);

always_ff @(posedge clk or posedge rst) begin
	 assign impact = 0; 
    if (rst) begin
        // No se realiza ninguna operación de ataque durante el reset
    end else begin
        if (player == 1) begin
            if (matrix[row][col] == 0)
                matrix[row][col] <= 9; // Si es jugador 1 y la casilla está vacía, nuevo valor es 9
            else
                matrix[row][col] <= matrix[row][col] + 10; // Si es jugador 1 y hay un barco, nuevo valor es el original + 10
					 assign impact = 1; 
        end else begin
            if (matrix[row][col] == 0)
                matrix[row][col] <= 9; // Si es jugador 2 y la casilla está vacía, nuevo valor es 9
            else
                matrix[row][col] <= 6; // Si es jugador 2 y hay un barco, nuevo valor es 6
					 assign impact = 1; 
        end
    end
end
endmodule