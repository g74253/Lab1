module GameController (
    input logic clk,                             // Reloj
    input logic rst,
	 input logic boton_arriba,
	 input logic boton_abajo,
	 input logic boton_izquierda,
	 input logic boton_derecha,
	 input logic boton_colocar,
	 input int player_board[4:0][4:0],
    input int pc_board [4:0][4:0],
	 output int newPlayer_board[4:0][4:0],
    output int newPc_board [4:0][4:0]
);

    // Declaración de estados del jugador
    typedef enum logic [3:0] {
        IDLE,
        PLAYER_ATTACK,
		  PC_ATTACK,
        LIFE_CONTROL,
        DSP_VGA,
        WIN_LOSE
    } game_state_t;
	 
	 
	 int player_ships = 5;     // barcos restantes del jugador
	 int pc_ships = 5; 
	 logic player_turn = 1;						//indica turno de jugador o pc

    logic [3:0] game_state;
    int attack_row;
    int attack_col;
	 
	 int player_life = 15;
	 int pc_life = 15;
	  
	 int new_life; 
	  
	 logic timeout;
	 
	 
	 logic ena_rowCol;
	 logic ena_attack_player;
	 logic ena_attack_pc;
	 logic ena_cont;
	 
	 logic end_rowCol;
	 logic end_attack_player;
	 logic end_attack_pc;
	 logic end_cont;
	
	 
	 int selected_row;
	 int selected_col;
	 
	 logic first_execution_done = 0;
	 
	 
	  initial begin
		  selected_row = 4;
	     selected_col = 4;
        newPlayer_board = player_board;
        newPc_board = pc_board;
     end
	 
	 AttackModule playerAttack(.ena_attack(ena_attack_player),
	                           .clk(clk),
										.rst(rt),
										.row(attack_row),
										.col(attack_col),
										.player(player_turn),
										.life(pc_life),
										.newLife(newLife),
										.end_attack(end_attack_player),
										.newMatrix(newPc_board));
										
										
	selectRowCol(.ena_rowCol(ena_rowCol),
				    .boton_arriba(boton_arriba),
				    .boton_abajo(boton_abajo),
				    .boton_izquierda(boton_izquierda),
				    .boton_derecha(boton_derecha),
				    .rst(rst),
				    .boton_colocar(boton_colocar),
				    .row(selected_row),
				    .col(selected_col)
	);	
		
	 AttackModule pcAttack(.ena_attack(ena_attack_pc),
	                       .clk(clk),
			  		   		  .rst(rt),
								  .row(selected_row),
								  .col(selected_col),
								  .player(pc_turn),
						   	  .life(player_life),
								  .newLife(newLife),
								  .end_attack(end_attack_pc),
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
						 if(end_rowCol == 1) begin
							 ena_rowCol = 0;
							 end_rowCol = 0;
						 end	
						 
						 ena_attack_player = 1;
						 if(end_attack_player == 1) begin
							 ena_attack_player = 0;
							 end_attack_player = 0;
						 end	 
							 
						 game_state <= LIFE_CONTROL;
						 
                end
                PC_ATTACK: begin
						
											
						game_state <= LIFE_CONTROL;
										
		
                end
                LIFE_CONTROL: begin
                    // Verificar si el jugador ha ganado
                    if (pc_life == 0) begin
                        game_state <= WIN_LOSE;
                    end
						  if (player_life == 0) begin
                        game_state <= WIN_LOSE;
								
                    end else begin
								game_state <= DSP_VGA;
						  end
                end
                DSP_VGA: begin
					 
                    //se instancia modulo de adrian
						 // Verificar si el jugador ha ganado
						 
                    if (player_turn == 1) begin
								player_turn = 2;   
                    end else begin
								player_turn = 1;
						  end 
						  game_state <= IDLE;
                end
					 WIN_LOSE: begin
					    //PASA ALGO ENCIENDE LED O MESTRA ALGO
						 
						 //se instancia modulo de adrian con info de final de juego
		
                end
            endcase
        end
    end

endmodule