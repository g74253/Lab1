module WinLoseModule (
    input wire clk,
    input wire rst,
    input wire [3:0] player_life, // Vida del jugador
    input wire [3:0] enemy_life, // Vida de la PC
    output reg player_win, // Señal de victoria del jugador
    output reg player_lose // Señal de derrota del jugador
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        player_win <= 0;
        player_lose <= 0;
    end else begin
        if (player_life == 0) begin
            player_lose <= 1; // El jugador pierde si todos sus barcos son destruidos
        end
        if (enemy_life == 0) begin
            player_win <= 1; // El jugador gana si destruye todos los barcos de la PC
        end
    end
end

endmodule