module control_deco_PC_logic (
    input logic [3:0] rd,
    input logic branch,
    input logic regw,
    output logic pcs
);
    // Lógica para determinar pcs
    always @(*) begin
        pcs = branch & regw & (rd == 4'b0000); // Ejemplo de condición para pcs
    end

endmodule
