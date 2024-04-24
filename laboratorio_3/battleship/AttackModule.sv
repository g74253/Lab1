module AttackModule(
	 output logic ena_attack,
    input logic clk,
    input logic rst,
    input int row,
    input int col,
    input logic player, //indica cual juegador esta atacando 1=player, 2=pc
	 output int newLife,
	 output logic end_attack,
	 output int newMatrix [4:0][4:0]
);



always_ff @(posedge clk or posedge rst) begin
    if (ena_attack==0) begin
        // No se realiza ninguna operación de ataque durante el reset
    end else begin
        if (player == 1) begin
            if (newMatrix[row][col] == 0)
                newMatrix[row][col] = 9; // Si es jugador 1 y la casilla está vacía, nuevo valor es 9
            else
                newMatrix[row][col] = newMatrix[row][col] + 10; // Si es jugador 1 y hay un barco, nuevo valor es el original + 10
					 newLife = newLife-1;
        end else begin
            if (newMatrix[row][col] == 0)
                newMatrix[row][col] = 9; // Si es jugador 2 y la casilla está vacía, nuevo valor es 9
            else
                newMatrix[row][col] = 6; // Si es jugador 2 y hay un barco, nuevo valor es 6
					 newLife = newLife-1;
        end
    end
	 
	 //falta agregar que si le pega a un barco le reste a la vida
	 ena_attack = 0;
end
endmodule