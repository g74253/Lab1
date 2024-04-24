
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
	logic end_setup

	
	/* Matriz del jugador */
	playerSetUp setup (.en_setup(en_setup),
							.boton_arriba(boton_arriba),
						   .boton_abajo(boton_abajo),
						   .boton_izquierda(boton_izquierda),
						   .boton_derecha(boton_derecha),
							.rst(rst)
							.boton_colocar(boton_colocar),
						   .matrix(player_board),
							.end_setup(end_setup);
	
	/* Matriz de la PC */
	pcSetUp setup  (.en_setup(en_setup),
							.boton_arriba(boton_arriba),
						   .boton_abajo(boton_abajo),
						   .boton_izquierda(boton_izquierda),
						   .boton_derecha(boton_derecha),
							.rst(rst)
							.boton_colocar(boton_colocar),
						   .matrix(player_board),
							.end_setup(end_setup);


	// Controllador del juego
	movement initial_shift (//.clk(clk),
							.enable((!Q[1] & !Q[0])),
							.direction(direction),
							.matrix(matrix), 
							.moved_matrix(moved_matrix), 
							.ready(M));

	// Summation
	summation sum 		   (//.clk(clk),
							.enable((!Q[1] & Q[0])),
							.direction(direction),
							.matrix(matrix_Q),
							.summed_matrix(summed_matrix), 
							.ready(S));

	// Movement after Summation
	movement final_shift   (//.clk(clk),
						    .enable((Q[1] & !Q[0])),
						    .direction(direction),
						    .matrix(matrix_Q),
						    .moved_matrix(moved_again_matrix), 
						    .ready(F));

	new_tile_gen new_tile  (.clk(clk),
						    .enable((Q[1] & Q[0])),
						    .rand_pos(position),
						    .matrix_Q(matrix_Q),
						    .matrix_D(new_tile_matrix));   				
				