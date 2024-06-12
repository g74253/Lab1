module adder #(parameter n = 8) (
    input logic [n-1:0] a,
    input logic [n-1:0] b, 
    output logic [n-1:0] y
);
    // Asignación directa de la suma de a y b a la salida y
    assign y = a + b;
endmodule





