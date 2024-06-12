module vga_controller #(
    parameter int CELL_HORIZONTAL_LENGHT = 36,  // Tamaño de la matriz horizontal
    parameter int CELL_VERTICAL_LENGHT = 20     // Tamaño de la matriz vertical
)(
    input logic clk, rst,
    input logic [7:0] q_b,
    output logic Hsynq,
    output logic Vsynq, blank, sync,
    output logic [7:0] Red,
    output logic [7:0] Green,
    output logic [7:0] Blue, 
    output logic clk_vga,
    output logic [31:0] address
);

    int values[CELL_HORIZONTAL_LENGHT * CELL_VERTICAL_LENGHT];
    int write_pointer = 0;
    logic clk_25M;
    logic [7:0] previous_q_b;
    logic new_data_flag;

    // Instanciación del divisor de reloj
clock_divider VGA_Clock_gen (
        clk, 
        clk_25M
    );
    // Instanciación del módulo de dibujo de VGA
vga_drawer #(
        .CELL_HORIZONTAL_LENGHT(CELL_HORIZONTAL_LENGHT),
        .CELL_VERTICAL_LENGHT(CELL_VERTICAL_LENGHT)
    ) vcg (clk_25M, rst, Hsynq, Vsynq, clk_vga, blank, sync, Red, Green, Blue,values); 

    // Lógica para escribir en el arreglo `values` y actualizar la dirección
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            write_pointer <= 0;
            previous_q_b <= 8'd0;
            new_data_flag <= 1'b0;
            address <= 32'd1;  // Inicializar la dirección en 1
            // Inicializar el array `values`
            for (int i = 0; i < CELL_HORIZONTAL_LENGHT * CELL_VERTICAL_LENGHT; i++) begin
                values[i] <= 0;
            end
        end else begin
            // Detectar nueva entrada en `q_b`
            if (q_b != previous_q_b) begin
                values[write_pointer] <= q_b;
                write_pointer <= write_pointer + 1;
                new_data_flag <= 1'b1;
                previous_q_b <= q_b;

                // Resetear el puntero si alcanza el final del arreglo
                if (write_pointer >= CELL_HORIZONTAL_LENGHT * CELL_VERTICAL_LENGHT) begin
                    write_pointer <= 0;
                end
            end else begin
                new_data_flag <= 1'b0;
            end

            // Incrementar la dirección en 1 por cada pulso de reloj
            if (address < CELL_HORIZONTAL_LENGHT * CELL_VERTICAL_LENGHT) begin
                address <= address + 1;
            end else begin
                address <= 32'd1;  // Reiniciar a 1 cuando se alcance el máximo
            end
        end
    end

endmodule
