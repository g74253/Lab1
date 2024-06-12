module control_deco_main_decoder (
    input logic [1:0] op,
    input logic funct5,
    input logic funct0,
    output logic regw,
    output logic memw,
    output logic memtoreg,
    output logic alusrc,
    output logic [1:0] immsrc,
    output logic [1:0] regsrc,
    output logic branch,
    output logic aluop
);
    // Lógica de decodificación principal
    always @(*) begin
        case (op)
            2'b00: begin
                regw = 1;
                memw = 0;
                memtoreg = 0;
                alusrc = 1;
                immsrc = 2'b00;
                regsrc = 2'b00;
                branch = 0;
                aluop = 0;
            end
            2'b01: begin
                regw = 0;
                memw = 1;
                memtoreg = 1;
                alusrc = 1;
                immsrc = 2'b01;
                regsrc = 2'b01;
                branch = 0;
                aluop = 0;
            end
            2'b10: begin
                regw = 1;
                memw = 0;
                memtoreg = 0;
                alusrc = 0;
                immsrc = 2'b10;
                regsrc = 2'b10;
                branch = funct0;
                aluop = 1;
            end
            2'b11: begin
                regw = 1;
                memw = 0;
                memtoreg = 0;
                alusrc = 0;
                immsrc = 2'b11;
                regsrc = 2'b11;
                branch = 0;
                aluop = 1;
            end
            default: begin
                regw = 0;
                memw = 0;
                memtoreg = 0;
                alusrc = 0;
                immsrc = 2'b00;
                regsrc = 2'b00;
                branch = 0;
                aluop = 0;
            end
        endcase
    end
endmodule