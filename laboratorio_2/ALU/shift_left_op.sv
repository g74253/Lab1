module shift_left_op(
    input logic [3:0] data_in,
    output logic [3:0] shifted_data
);

assign shifted_data = {data_in[2:0], 1'b0}; // Desplaza los bits hacia la izquierda y añade un 0 al final

endmodule
