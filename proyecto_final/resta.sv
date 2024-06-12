module resta
    #(parameter n = 32)
    (
        input logic [n-1:0] entrada1,
        input logic [n-1:0] entrada2,
        output logic [n-1:0] resultado,
        output logic carry,
        output logic negativo,
        output logic desbordamiento,
        output logic cero
    );

    logic [n-1:0] complemento2;

    assign complemento2 = ~entrada2 + 1; // complemento a 2 de entrada2
    assign {carry, resultado} = entrada1 + complemento2;
    assign negativo = resultado[n-1];
    assign desbordamiento = (entrada1[n-1] != complemento2[n-1]) && (resultado[n-1] != entrada1[n-1]);
    assign cero = (resultado == 0);

endmodule
