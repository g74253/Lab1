
module GameStart(input logic boton_arriba,
				input logic boton_abajo,
				input logic boton_izquierda,
				input logic boton_derecha,
				input logic rst,
				input logic boton_colocar
);

	logic [2:0] cant_barco = 3'b101; //cantidad de barcos = 5

	logic player_end_setup;
	logic pc_end_setup;
	
	logic iniciar;
	logic ena_setup;
	logic ena_setup_pc;
	
	logic [2:0] rand_x;
	logic [2:0] rand_y;
	
	int player_board[4:0][4:0];
	int pc_board[4:0][4:0];
	
	
	/* Matriz del jugador */
	setup player_setup (.en_setup(ena_setup),
							.boton_arriba(boton_arriba),
						   .boton_abajo(boton_abajo),
						   .boton_izquierda(boton_izquierda),
						   .boton_derecha(boton_derecha),
							.rst(rst),
							.boton_colocar(boton_colocar),
						   .matrix(player_board),
							.end_setup(player_end_setup));
	
	/* Matriz de la PC */
	setup_pc pc_setup (.en_setup_pc(ena_setup_pc),
							.rand_x(rand_x),
							.rand_y(rand_y),
							.cant_barco(cant_barco),
							.rst(rst),
						   .matrix(pc_board),
							.end_setup(pc_end_setup));

	
	// Controllador del juego
	GameController gameController (.clk(clk),
											.rst(rt),
											.boton_arriba(boton_arriba),
				                     .boton_abajo(boton_abajo),
				                     .boton_izquierda(boton_izquierda),
				                     .boton_derecha(boton_derecha),
				         				.boton_colocar(boton_colocar), 
											.player_board(player_board), 
											.pc_board(pc_board));
						
						
endmodule				
				