module vga_controller #(    
    parameter int CELL_HORIZONTAL_LENGHT = 36,  // Tamaño de la matriz horizontal
    parameter int CELL_VERTICAL_LENGHT = 20     // Tamaño de la matriz vertical
)(
    input logic clk, rst,
    input logic button,
    input logic [7:0]  q_b,
    output logic Hsynq,
    output logic Vsynq, blank, sync,
    output logic [7:0] Red,
    output logic [7:0] Green,
    output logic [7:0] Blue, 
    output logic clk_vga
);
    
    int values[CELL_HORIZONTAL_LENGHT * CELL_VERTICAL_LENGHT];
    int write_pointer = 0;
    logic clk_25M;

    clock_divider VGA_Clock_gen (clk, clk_25M);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            write_pointer <= 0;
        end else if (button) begin
            values[write_pointer] <= q_b;
            write_pointer <= (write_pointer + 1) % (CELL_HORIZONTAL_LENGHT * CELL_VERTICAL_LENGHT);
        end
    end


	 
	 vga_drawer #(
        .CELL_HORIZONTAL_LENGHT(CELL_HORIZONTAL_LENGHT),
        .CELL_VERTICAL_LENGHT(CELL_VERTICAL_LENGHT)
    ) vcg (clk_25M, rst, Hsynq, Vsynq, clk_vga, blank, sync, Red, Green, Blue,values); 

	 
	 

endmodule
