module suma_parametrizable
    #(parameter n = 4)
    (
        input  logic [n-1:0] entrada1,
        input  logic [n-1:0] entrada2,
        output logic [n-1:0] resultado,
        output logic carry,
        output logic cero
    );

    wire [n-1:0] temp_carry;
    genvar i;

    generate
        for (i = 0; i < n; i = i + 1) begin : generate_suma
            if (i == 0)
                suma sum_nc (
                    .entrada1(entrada1[i]),
                    .entrada2(entrada2[i]),
                    .carry_in(1'b0),
                    .resultado(resultado[i]),
                    .carry_out(temp_carry[i])
                ); // nc = no carry
            else
                suma sum_c (
                    .entrada1(entrada1[i]),
                    .entrada2(entrada2[i]),
                    .carry_in(temp_carry[i-1]),
                    .resultado(resultado[i]),
                    .carry_out(temp_carry[i])
                ); // c = carry
        end
    endgenerate

    assign carry = temp_carry[n-1];
    assign cero = (resultado == 0);

endmodule
