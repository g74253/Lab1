module registro_unit (
    input logic clk,
    input logic [3:0] a1,
    input logic [3:0] a2,
    input logic [3:0] a3,
    input logic [15:0] wd3,
    input logic [15:0] r15,
    input logic we3,
    output logic [15:0] rd1,
    output logic [15:0] rd2
);

    logic [31:0] register [15:0]; // Registro de 16 posiciones de 16 bits

    always @(posedge clk) begin
        if (we3) begin // Solo escribe en el registro si we3 está activo
            register[a3] <= wd3; // <= para asignación síncrona en el flanco de subida del reloj
        end
    end

    // Salidas del registro
    assign rd1 = (a1 == 4'b1111) ? r15 : register[a1];
    assign rd2 = (a2 == 4'b1111) ? r15 : register[a2];

endmodule
