module Player (
    input wire clk,                             // Reloj
    input wire rst,                             // Reset
    input wire [4:0] selected_row,             // Fila seleccionada por el jugador
    input wire [4:0] selected_col,             // Columna seleccionada por el jugador
    input wire [4:0] enemy_board [0:4][0:4],   // Tablero de la PC
    output reg [4:0] player_board [0:4][0:4],  // Tablero del jugador
    output reg player_hit,                     // Señal de impacto del jugador
    output reg [3:0] player_life,              // Vida del jugador
    output reg player_win,                     // Señal de victoria del jugador
    output reg player_lose                     // Señal de derrota del jugador
);

    // Parámetros
    parameter WAIT_TIME = 15;  // Tiempo de espera en segundos

    // Declaración de estados del jugador
    typedef enum logic [3:0] {
        IDLE,
        ATTACK,
        CHECK_HIT,
        CHECK_WIN,
        CHECK_LOSE
    } player_state_t;

    // Señales internas
    reg [3:0] player_state;
    reg [4:0] attack_row;
    reg [4:0] attack_col;
    reg [3:0] wait_counter;
    reg hit;  // Señal de impacto del jugador

    // Lógica del jugador
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            player_state <= IDLE;
            player_hit <= 0;
            player_win <= 0;
            player_lose <= 0;
            wait_counter <= 0;
        end else begin
            case (player_state)
                IDLE: begin
                    // Esperar a que el jugador seleccione una casilla
                    if (selected_row != 5 && selected_col != 5) begin
                        player_state <= ATTACK;
                        attack_row <= selected_row;
                        attack_col <= selected_col;
                        wait_counter <= WAIT_TIME;  // Iniciar temporizador para el tiempo de espera
                    end
                end
                ATTACK: begin
                    // Realizar el ataque
                    player_board[attack_row][attack_col] <= 1;  // Marcar la casilla en el tablero del jugador
                    player_state <= CHECK_HIT;
                end
                CHECK_HIT: begin
                    // Verificar si el jugador ha impactado un barco enemigo
                    if (attack_row != 5 && attack_col != 5) begin
                        if (hit) begin
                            player_hit <= 1;  // Señalizar que se ha realizado un impacto
                        end else begin
                            player_hit <= 0;
                        end
                        player_state <= CHECK_WIN;
                    end
                end
                CHECK_WIN: begin
                    // Verificar si el jugador ha ganado
                    if (player_win == 1) begin
                        // Señalizar que el jugador ha ganado
                        player_state <= IDLE;  // Volver al estado IDLE
                    end else begin
                        player_state <= CHECK_LOSE;  // Si no ha ganado, verificar si ha perdido
                    end
                end
                CHECK_LOSE: begin
                    // Verificar si el jugador ha perdido
                    if (player_lose == 1) begin
                          // Señalizar que el jugador ha perdido
                        player_state <= IDLE;  // Volver al estado IDLE
                    end else begin
                        player_state <= IDLE;  // Si no ha perdido, volver al estado IDLE
                    end
                end
            endcase
            // Temporizador de espera
            if (wait_counter > 0) begin
                wait_counter <= wait_counter - 1;
            end
        end
    end

endmodule