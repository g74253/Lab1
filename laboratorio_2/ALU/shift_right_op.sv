module shift_right_op(
    input logic  data_in,
    output logic  shifted_data
);

assign shifted_data = {1'b0, data_in[3:1]}; // Desplaza los bits hacia la derecha y añade un 0 al principio

endmodule
