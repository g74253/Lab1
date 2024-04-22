module AttackModule(
    input wire clk,
    input wire rst,
    input wire [4:0] selected_row,
    input wire [4:0] selected_col,
    input wire [4:0] enemy_board [0:4][0:4], // Tablero de la PC
    output reg hit // Señal de impacto
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        hit <= 0;
    end else begin
        if (enemy_board[selected_row][selected_col] == 1) begin
            hit <= 1; // Hay un barco enemigo en esa casilla
        end else begin
            hit <= 0; // No hay un barco enemigo en esa casilla
        end
    end
end

endmodule