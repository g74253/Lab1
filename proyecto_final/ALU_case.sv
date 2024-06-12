module ALU_case
    #(parameter n = 32)
    (
        input logic [n-1:0] entrada1,
        input logic [n-1:0] entrada2,
        input logic [1:0] alucontrol,
        output logic [n-1:0] resultado,
        output logic carry,
        output logic cero,
        output logic negativo,
        output logic desbordamiento
    );

    // Variables temporales para la suma
    logic [n-1:0] temp_resultado_suma;
    logic temp_carry_suma;
    logic temp_cero_suma;

    // Variables temporales para la resta
    logic [n-1:0] temp_resultado_resta;
    logic temp_carry_resta;
    logic temp_negativo_resta;
    logic temp_cero_resta;
    logic temp_desbordamiento_resta;

    // Variables temporales para AND
    logic [n-1:0] temp_resultado_And;
    logic temp_cero_And;

    // Variables temporales para OR
    logic [n-1:0] temp_resultado_Or;
    logic temp_cero_Or;

    // Instancias de los módulos de operaciones
    suma_parametrizable #(n) suma_inst (
        .entrada1(entrada1),
        .entrada2(entrada2),
        .resultado(temp_resultado_suma),
        .carry(temp_carry_suma),
        .cero(temp_cero_suma)
    );

    resta #(n) resta_inst (
        .entrada1(entrada1),
        .entrada2(entrada2),
        .resultado(temp_resultado_resta),
        .carry(temp_carry_resta),
        .negativo(temp_negativo_resta),
        .desbordamiento(temp_desbordamiento_resta),
        .cero(temp_cero_resta)
    );

    and_op #(n) and_inst (
        .entrada1(entrada1),
        .entrada2(entrada2),
        .resultado(temp_resultado_And),
        .cero(temp_cero_And)
    );

    or_op #(n) or_inst (
        .entrada1(entrada1),
        .entrada2(entrada2),
        .resultado(temp_resultado_Or),
        .cero(temp_cero_Or)
    );

    always @(*) begin
        case (alucontrol)
            2'b00: // Suma
                begin
                    resultado = temp_resultado_suma;
                    carry = temp_carry_suma;
                    cero = temp_cero_suma;
                    negativo = temp_resultado_suma[n-1];
                    desbordamiento = 0; // Puedes ajustar esto según sea necesario
                end
            2'b01: // Resta
                begin
                    resultado = temp_resultado_resta;
                    carry = temp_carry_resta;
                    cero = temp_cero_resta;
                    negativo = temp_negativo_resta;
                    desbordamiento = temp_desbordamiento_resta;
                end
            2'b10: // AND
                begin
                    resultado = temp_resultado_And;
                    carry = 0;
                    cero = temp_cero_And;
                    negativo = temp_resultado_And[n-1];
                    desbordamiento = 0;
                end
            2'b11: // OR
                begin
                    resultado = temp_resultado_Or;
                    carry = 0;
                    cero = temp_cero_Or;
                    negativo = temp_resultado_Or[n-1];
                    desbordamiento = 0;
                end
            default: // Por si acaso
                begin
                    resultado = 0;
                    carry = 0;
                    cero = 1;
                    negativo = 0;
                    desbordamiento = 0;
                end
        endcase
    end
endmodule
