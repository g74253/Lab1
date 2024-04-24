
module GameStart(input logic boton_arriba,
				input logic boton_abajo,
				input logic boton_izquierda,
				input logic boton_derecha,
				input logic rst,
				input logic boton_colocar
);

	logic en_setup = 1; //inicia el setup
	logic [2:0] cant_barco = 3'b101 //cantidad de barcos = 5
	int player_board[4:0][4:0];
	int pc_board[4:0][4:0];
	logic player_end_setup;
	logic pc_end_setup;
	
	/* Matriz del jugador */
<<<<<<< Updated upstream
	setup player_setup (.en_setup(en_setup),
=======
	Setup player_setup(
							.en_setup(ena_setup),
>>>>>>> Stashed changes
							.boton_arriba(boton_arriba),
						   .boton_abajo(boton_abajo),
						   .boton_izquierda(boton_izquierda),
						   .boton_derecha(boton_derecha),
<<<<<<< Updated upstream
							.rst(rst)
							.boton_colocar(boton_colocar),
						   .matrix(player_board),
							.end_setup(player_end_setup);
=======
							.cant_barco(cant_barco),
							.rst(rst),
							.boton_colocar(boton_colocar),
						   .matrix(player_board),
							.end_setup(player_end_setup));
							
							

>>>>>>> Stashed changes
	
	/* Matriz de la PC */
	setup pc_setup (.en_setup(en_setup),
							.boton_arriba(boton_arriba),
						   .boton_abajo(boton_abajo),
						   .boton_izquierda(boton_izquierda),
						   .boton_derecha(boton_derecha),
							.rst(rst)
							.boton_colocar(boton_colocar),
						   .matrix(pc_board),
							.end_setup(pc_end_setup);


	// Controllador del juego
	GameController gameController (.clk(clk),
											.rst(rt),
											.matrix(matrix), 
											.player_board(player_board), 
											.pc_board(pc_board));
						
						
endmodule				
