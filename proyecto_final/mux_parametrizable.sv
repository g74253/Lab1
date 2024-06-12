module mux_parametrizable #(parameter n = 8)(
    input logic [n-1:0] input1,
    input logic [n-1:0] input2,
    input logic select,
    output logic [n-1:0] final_output
);
    // Asignación directa de input1 o input2 a final_output basado en select
    assign final_output = select ? input2 : input1;
endmodule


