module LifeControl (
    input wire clk,
    input wire rst,
    input wire player_hit, // Señal de impacto del jugador
    input wire enemy_hit, // Señal de impacto de la PC
    output reg [3:0] player_life, // Vida del jugador
    output reg [3:0] enemy_life // Vida de la PC
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        player_life <= 5; // Cantidad inicial de barcos del jugador
        enemy_life <= 5; // Cantidad inicial de barcos de la PC
    end else begin
        if (player_hit) begin
            player_life <= player_life - 1; // Se decrementa la vida del jugador si recibe un impacto
        end
        if (enemy_hit) begin
            enemy_life <= enemy_life - 1; // Se decrementa la vida de la PC si recibe un impacto
        end
    end
end

endmodule