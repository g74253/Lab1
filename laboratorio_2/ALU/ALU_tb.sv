module ALU_tb;

    logic [3:0] entrada1 = 0;
    logic [3:0] entrada2 = 0;
    logic [3:0] selector = 0;
    logic [6:0] display1;
    logic [6:0] display2;
    logic carry;
    logic cero;

    // Instancia del módulo bajo prueba
    ALU_deco #(4) dut (
        .entrada1(entrada1),
        .entrada2(entrada2),
        .selector(selector),
        .display1(display1),
        .display2(display2),
        .carry(carry),
        .cero(cero)
    );

	 
	     // Generación de estímulos
    initial begin
        // Aplicar estímulos después de 5 unidades de tiempo
        #5;
        // Configurar parámetros de prueba
        selector = 0;
        entrada1 = 2;
        entrada2 = 4;
        // Esperar 40 unidades de tiempo antes de finalizar la simulación
        #40;
        // Finalizar la simulación
        $finish;
    end

    // Imprimir resultados
    always @* begin
        $display("Resultado: display1=%h, display2=%h, carry=%b, cero=%b", display1, display2, carry, cero);
    end
	 
endmodule