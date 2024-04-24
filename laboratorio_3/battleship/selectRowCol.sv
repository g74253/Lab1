module selectRowCol(
    input logic ena_rowCol,
    input logic boton_arriba,
    input logic boton_abajo,
    input logic boton_izquierda,
    input logic boton_derecha,
    input logic rst,
    input logic boton_colocar,
    output int row,
    output int col,
    output logic end_rowCol
);

    // Variables locales
    logic [2:0] row_internal;
    logic [2:0] col_internal;

    // Proceso para seleccionar fila y columna
    always @(*) begin
        if (rst) begin
            // Restablece los valores durante el reset
            row_internal = 0;
            col_internal = 0;
            end_rowCol = 0;
        end else if (ena_rowCol) begin
            // Actualiza la fila y la columna según los botones presionados
            if (boton_arriba && col_internal != 4) begin
                col_internal = col_internal + 1;
            end else if (boton_abajo && col_internal != 0) begin
                col_internal = col_internal - 1;
            end else if (boton_izquierda && row_internal != 4) begin
                row_internal = row_internal + 1;
            end else if (boton_derecha && row_internal != 0) begin
                row_internal = row_internal - 1;
            end else if (boton_colocar) begin
                // Indica que se ha completado la selección de fila y columna
                end_rowCol = 1;
            end
        end
    end

    // Asignación de los valores internos a las salidas
    assign row = row_internal;
    assign col = col_internal;

endmodule
