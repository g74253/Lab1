module condition_check (
    input logic [3:0] cond,
    input logic [1:0] flags32,
    input logic [1:0] flags10,
    output logic condex
);
    // Comentarios explicativos sobre las banderas:
    // flags32[0] -> neg (Negativo)
    // flags32[1] -> zero (Cero)
    // flags10[0] -> carry (Acarreo)
    // flags10[1] -> overflow (Desbordamiento)

    always @(*) begin
        case (cond)
            4'b0000: condex = flags10[1];    // Z (Cero)
            4'b0001: condex = !flags10[1];   // ~Z (No Cero)
            4'b0010: condex = flags32[0];    // N (Negativo)
            4'b0011: condex = !flags32[0];   // ~N (No Negativo)
            4'b0100: condex = flags10[0];    // C (Acarreo)
            4'b0101: condex = !flags10[0];   // ~C (No Acarreo)
            4'b1110: condex = 1'b1;          // Always true (Siempre Verdadero)
            default: condex = 1'bx;          // Condición indefinida
        endcase
    end
endmodule
