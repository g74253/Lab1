module AttackModule(
<<<<<<< Updated upstream
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
=======
    input logic ena_attack,
    input logic clk,
    input logic rst,
    input int currentLife,
    input int row,
    input int col,
    input logic player, //indica cual jugador esta atacando 1=player, 2=pc
    output int newLife,
    output int newMatrix [4:0][4:0]
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        // Restablece los valores durante el reset
        newLife = 0;
        for (int i = 0; i < 5; i = i + 1) begin
            for (int j = 0; j < 5; j = j + 1) begin
                newMatrix[i][j] = 0;
            end
        end
    end else if (ena_attack) begin
        // Realiza la operación de ataque si ena_attack está activo
>>>>>>> Stashed changes
        if (player == 1) begin
            if (matrix[row][col] == 0)
                matrix[row][col] <= 9; // Si es jugador 1 y la casilla está vacía, nuevo valor es 9
            else
<<<<<<< Updated upstream
                matrix[row][col] <= matrix[row][col] + 10; // Si es jugador 1 y hay un barco, nuevo valor es el original + 10
					 assign impact = 1; 
=======
                newMatrix[row][col] = newMatrix[row][col] + 10; // Si es jugador 1 y hay un barco, nuevo valor es el original + 10
            newLife = currentLife - 1;
>>>>>>> Stashed changes
        end else begin
            if (matrix[row][col] == 0)
                matrix[row][col] <= 9; // Si es jugador 2 y la casilla está vacía, nuevo valor es 9
            else
<<<<<<< Updated upstream
                matrix[row][col] <= 6; // Si es jugador 2 y hay un barco, nuevo valor es 6
					 assign impact = 1; 
=======
                newMatrix[row][col] = 6; // Si es jugador 2 y hay un barco, nuevo valor es 6
            newLife = currentLife - 1;
>>>>>>> Stashed changes
        end
    end
end

endmodule
