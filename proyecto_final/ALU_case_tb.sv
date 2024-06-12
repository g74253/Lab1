module ALU_case_tb;

    parameter n = 32;

    // Inputs
    logic [n-1:0] entrada1;
    logic [n-1:0] entrada2;
    logic [1:0] alucontrol;

    // Outputs
    logic [n-1:0] resultado;
    logic carry;
    logic cero;
    logic negativo;
    logic desbordamiento;

    // Instancia de la ALU
    ALU_case #(n) uut (
        .entrada1(entrada1),
        .entrada2(entrada2),
        .alucontrol(alucontrol),
        .resultado(resultado),
        .carry(carry),
        .cero(cero),
        .negativo(negativo),
        .desbordamiento(desbordamiento)
    );

    // Procedimiento de prueba
    initial begin
        // Inicialización de las señales
        entrada1 = 32'b0;
        entrada2 = 32'b0;
        alucontrol = 2'b00;

        // Prueba de la operación Suma
        entrada1 = 32'd15;
        entrada2 = 32'd10;
        alucontrol = 2'b00;
        #10;
        $display("Suma: entrada1=%d, entrada2=%d, resultado=%d, carry=%b, cero=%b, negativo=%b, desbordamiento=%b",
                 entrada1, entrada2, resultado, carry, cero, negativo, desbordamiento);

        // Prueba de la operación Resta
        entrada1 = 32'd20;
        entrada2 = 32'd10;
        alucontrol = 2'b01;
        #10;
        $display("Resta: entrada1=%d, entrada2=%d, resultado=%d, carry=%b, cero=%b, negativo=%b, desbordamiento=%b",
                 entrada1, entrada2, resultado, carry, cero, negativo, desbordamiento);

        // Prueba de la operación AND
        entrada1 = 32'hFF00FF00;
        entrada2 = 32'h00FF00FF;
        alucontrol = 2'b10;
        #10;
        $display("AND: entrada1=%h, entrada2=%h, resultado=%h, carry=%b, cero=%b, negativo=%b, desbordamiento=%b",
                 entrada1, entrada2, resultado, carry, cero, negativo, desbordamiento);

        // Prueba de la operación OR
        entrada1 = 32'hFF00FF00;
        entrada2 = 32'h00FF00FF;
        alucontrol = 2'b11;
        #10;
        $display("OR: entrada1=%h, entrada2=%h, resultado=%h, carry=%b, cero=%b, negativo=%b, desbordamiento=%b",
                 entrada1, entrada2, resultado, carry, cero, negativo, desbordamiento);

        // Fin de la simulación
        $stop;
    end
endmodule