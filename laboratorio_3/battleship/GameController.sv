module GameController (
    input logic clk,                             // Reloj
    input logic rst,
	 input logic boton_arriba,
	 input logic boton_abajo,
	 input logic boton_izquierda,
	 input logic boton_derecha,
	 input logic boton_colocar
);

    // Declaración de estados del jugador
    typedef enum logic [3:0] {
        IDLE,
        ATTACK,
        CHECK_HIT,
        CHECK_WIN,
        CHECK_LOSE
    } player_state_t;
	 
	 int player_board[4:0][4:0];   // Tablero jugador
    int pc_board [4:0][4:0];  //tablero pc

    // Señales internas
    reg [3:0] player_state;
    reg [4:0] attack_row;
    reg [4:0] attack_col;
    reg [3:0] wait_counter;

    reg hit;  // Señal de impacto del jugador

    logic [3:0] game_state;
	 
	 int player_life; //vida total del jugador 
	 int pc_life; //vida de la pc
	  
	 logic timeout; //variable para indicar timeout del jugador 15 seg
	 
	 
	 logic ena_rowCol;
	 logic ena_attack_player;
	 logic ena_attack_pc;
	 logic ena_cont;

	  int newPlayer_board[4:0][4:0];
     int newPc_board [4:0][4:0];

	 
	 logic end_rowCol;
	 logic end_attack_player;
	 logic end_attack_pc;
	 logic end_cont;
	
	 
	 int selected_row; //fila elegida para atacar
	 int selected_col; //col elegida para atacar


	 int newPlayerLife;
	 int newPcLife;
	 
	 logic first_execution_done = 0;
	 





	  initial begin
		 
		  player_ships = 5; //inicia con 5 barcos
		  pc_ships = 5; //inicia con 5 barcos
		  player_turn = 1	; //inicia jugando el player
		  player_life = 15; //inician con 15 de vida (5+4+3+2+1)
        pc_life = 15; //inician con 15 de vida (5+4+3+2+1)
        newPc_board = pc_board;
     end
	 
	 //modulo de ataque para el jugador, le pasa la matriz de la pc
	 // y pasa la columna y fila para ataque
	 AttackModule playerAttack(
								.ena_attack(ena_attack_player),
								.clk(clk),
								.rst(rt),
								.currentLife(pc_life),
								.row(attack_row),
								.col(attack_col),
								.player(player_turn),
								.newLife(newPcLife),
								.newMatrix(newPc_board));
										
										

	 AttackModule pcAttack(.ena_attack(ena_attack_pc),
	                       .clk(clk),
			  		   		  .rst(rt),
							  .currentLife(player_life),
							  .row(selected_row),
							  .col(selected_col),
							  .player(pc_turn),
						   	  .newLife(newPlayerLife),
								  .newMatrix(newPlayer_board));
								  
	
	
	contador cont (.ena_attack(ena_cont),
		  			  .clk(clk),
			  		  .timeout(timeout));
					  
	selectRowCol selectRC(.ena_rowCol(ena_rowCol),
								 .boton_arriba(boton_arriba),
								 .boton_abajo(boton_abajo),
								 .boton_izquierda(boton_izquierda),
								 .boton_derecha(boton_derecha),
								 .rst(rst),
								 .boton_colocar(boton_colocar),
								 .row(selected_row),
								 .col(selected_col),
								 .end_rowCol(end_rowCol));				  
   

			


    // Lógica del jugador
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            game_state <= IDLE;
			player_life <= 15;
	        pc_life <= 15;
        end else begin
			player_life <= newPlayerLife;
			pc_life <= newPcLife;
			


            case (game_state)
                IDLE: begin
                    // Esperar a que el jugador seleccione una casilla
                    if (player_turn == 1) begin
                        game_state <= PLAYER_ATTACK;
                    end else begin
								game_state <= PC_ATTACK;
						  end
                end
                PLAYER_ATTACK: begin
					 	 
						 ena_rowCol = 1; 
						 ena_attack_player <= 1;
						 
						
						 game_state <= LIFE_CONTROL;
						 
                end
                PC_ATTACK: begin
						ena_rowCol = 0; 
						ena_attack_pc<=1;
						game_state <= LIFE_CONTROL;
										
		
                end
                LIFE_CONTROL: begin

					ena_attack_player <= 0;
					ena_attack_pc<=0;


                    // Verificar si el jugador ha ganado
                    if (pc_life == 0) begin
                        game_state <= WIN_LOSE;
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