module GameController (
    input logic clk,                             // Reloj
    input logic rst,                             // Reset
	 input logic player						//indica turno de jugador o pc
    input logic row [4:0],             // Fila seleccionada por el jugador
    input logic col [4:0],             // Columna seleccionada por el jugador
    output logic [3:0] player_ships,     // barcos restantes del jugador
	 output logic [3:0] pc_ships,              // barcos restantes jugador
    output logic lose_win,                     // Señal de victoria o derrota
);

    // Declaración de estados del jugador
    typedef enum logic [3:0] {
        IDLE,
        ATTACK,
        CHECK_HIT,
        CHECK_WIN,
        CHECK_LOSE
    } player_state_t;
	 
	 int player_board[4:0][4:0],   // Tablero jugador
    int pc_board [4:0][4:0],  //tablero pc

    // Señales internas
    reg [3:0] player_state;
    reg [4:0] attack_row;
    reg [4:0] attack_col;
    reg [3:0] wait_counter;
	 player_life <= 15;
	 pc_life <= 15;
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