module GameStart_tb;

	logic clk;
	logic rst;
	logic boton_arriba;
	logic boton_abajo;
	logic boton_izquierda;
	logic boton_derecha;
	logic boton_colocar;
	
	GameStart juego (.boton_arriba(boton_arriba),
							.boton_abajo(boton_abajo),
							.boton_izquierda(boton_izquierda),
							.boton_derecha(boton_derecha),
							.rst(rst),
							.clk(clk),
							.boton_colocar(boton_colocar));
	
	always begin
		#10 clk = ~clk;
	end
	
	initial begin
		clk = 0;
		boton_izquierda = 0;
		boton_derecha = 0;
		boton_colocar = 0;
		boton_arriba = 0;
		boton_abajo = 0;
		rst = 1;
		#10
		rst = 0;
		boton_izquierda = 1;
		#10
		boton_izquierda = 0;
		boton_abajo = 1;
		#10
		boton_abajo = 0;
		boton_colocar = 1;
		#10
		boton_colocar = 0;
		boton_abajo = 1;
		#10
		boton_abajo = 0;
		boton_colocar = 1;
		#10
		boton_colocar = 0;
		#10
		
		$stop;
	end

endmodule