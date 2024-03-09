module mult #(
    parameter M = 4
)(
    input logic signed [M-1:0] A,
    input logic signed [M-1:0] B,
    output logic signed [2*M-1:0] R,
    output logic C,
    output logic N,
    output logic V,
    output logic Z
);

    logic signed [2*M-1:0] temp_R;
    logic [2*M:0] carry;

    // Multiplicación parcial
    always_comb begin
        temp_R = 0;
        carry = 0;
        for (int i = 0; i < M; i++) begin
            if (B[i] == 1'b1) begin
                // Realizar la multiplicación y sumar al resultado parcial
                {temp_R, carry} = temp_R + (A << i) + carry;
            end
        end
        R = temp_R;
        C = carry[M];
        N = (temp_R < 0);
        V = 0; // No se usa en la multiplicación
        Z = (temp_R == 0);
    end

endmodule
