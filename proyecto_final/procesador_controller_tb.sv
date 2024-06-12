`timescale 1ns / 1ps

module procesador_controller_tb;
// Parámetros de tiempo
    parameter CLK_PERIOD = 10;

    // Señales de entrada
    logic clk;
    logic rst;
    logic wren_b;

    // Señales de salida
		logic [7:0] q_b;
		logic Hsynq;
		logic Vsynq, blank, sync;
		logic [7:0] Green;
		logic [7:0] Red;
		logic [7:0] Blue;
		logic clk_vga;

    // Instancia del procesador
    procesador_controller uut(.clk(clk),
								 .rst(rst),
								 .wren_b(wren_b),
								 .Hsynq(Hsynq),
								 .Vsynq(Vsynq), 
								 .blank(blank), 
								 .sync(sync),
								 .Green(Green),
								 .Red(Red),
								 .q_b(q_b),
								 .Blue(Blue),
								 .clk_vga(clk_vga)
								 );

    // Generación de reloj
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Inicialización
    initial begin
        clk = 0;
        rst = 1;
        wren_b = 0;

        // Espera unos ciclos de reloj para el reinicio
        #((CLK_PERIOD * 10));

        // Desactivar reinicio
        rst = 0;

        // Ejecución de instrucciones
        // Simulación de carga de datos en direcciones de memoria específicas
        // y verificación del resultado esperado

        // Prueba 1: Cargar datos en una dirección de memoria y leerlos
        // Se espera que q_b sea igual al valor cargado
        // Leer datos de la dirección de memoria cargada
        #((CLK_PERIOD * 2)); // Esperar un ciclo de reloj
        // Verificar el resultado esperado
        if (q_b === 8'hFF) begin
            $display("Prueba 1 pasada: Valor leído correcto.");
        end else begin
            $display("Prueba 1 fallida: Valor leído incorrecto.");
        end

        // Otras pruebas similares aquí...

        // Finalizar simulación
        #((CLK_PERIOD * 10)); // Esperar un tiempo adicional antes de finalizar
        $stop;
	  end

endmodule