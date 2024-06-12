module and_op
    #(parameter n = 32)
    (
        input logic [n-1:0] entrada1,
        input logic [n-1:0] entrada2,
        output logic [n-1:0] resultado,
        output logic cero
    );

    assign resultado = entrada1 & entrada2;
    assign cero = (resultado == 0);

endmodule