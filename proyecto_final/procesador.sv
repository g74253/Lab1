module procesador (
    input logic clk,
    input logic rst,
    input logic wren_b,
    input logic [31:0] address,
    output logic [7:0] q_b
);

    // Declaración de señales internas
    logic [31:0] pc;
    logic [31:0] instr;
    logic [3:0] aluflags;
    logic pcsrc, memtoreg, memwrite, alusrc, regwrite;
    logic [1:0] alucontrol, immsrc, regsrc;
    logic [31:0] pcplus4, pcplus8, ra3, ra5, ra4, aluresult, extimm;
    logic [3:0] ra1, ra2;
    logic [15:0] rd1, rd2;
    logic [7:0] readata;
    
    // Instancias de los módulos
    
    // Memoria de Instrucciones
    inst_mem mem_inst (
        .address(pc),
        .clock(clk),
        .q(instr)
    );

    // Unidad de Control
    control_unit control_inst (
        .cond(instr[31:28]),
        .op(instr[27:26]),
        .funct(instr[25:20]),
        .rd(instr[15:12]),
        .aluflags(aluflags),
        .clk(clk),
        .pcsrc(pcsrc),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .alucontrol(alucontrol),
        .alusrc(alusrc),
        .immsrc(immsrc),
        .regwrite(regwrite),
        .regsrc(regsrc)
    );

    // Unidad de Manejo de Inmediatos
    imm_unit inmediat_inst (
        .immsrc(immsrc),
        .inmediato(instr[23:0]),
        .extimm(extimm)
    );

    // Multiplexor A
    mux_parametrizable mux_a (
        .input1(instr[19:16]),
        .input2(4'b1111),
        .select(regsrc[0]),
        .final_output(ra1)
    );

    // Multiplexor B
    mux_parametrizable mux_b (
        .input1(instr[3:0]),
        .input2(instr[15:12]),
        .select(regsrc[1]),
        .final_output(ra2)
    );

    // Registro
    registro_unit regist_inst (
        .clk(clk),
        .a1(ra1),
        .a2(ra2),
        .a3(instr[15:12]),
        .wd3(ra4),
        .r15(pcplus8),
        .we3(regwrite),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Multiplexor C
    mux_parametrizable mux_c (
        .input1(rd2[0]),
        .input2(extimm),
        .select(alusrc),
        .final_output(ra3)
    );

    // Memoria de Datos
    data_mem datmem_inst (
        .address_a(aluresult),
        .address_b(address),
        .clock(clk),
        .data_a(rd2),
        .data_b(),
        .wren_a(memwrite),
        .wren_b(wren_b),
        .q_a(readata),
        .q_b(q_b)
    );

    // ALU
    ALU_case alu_inst (
        .entrada1(rd1),
        .entrada2(ra3),
        .alucontrol(alucontrol),
        .resultado(aluresult),
        .carry(aluflags[2]),
        .cero(aluflags[1]),
        .negativo(aluflags[0]),
        .desbordamiento(aluflags[3])
    );

    // Multiplexor D
    mux_parametrizable mux_d (
        .input1(readata),
        .input2(aluresult),
        .select(memtoreg),
        .final_output(ra4)
    );

    // Sumador PC+4
    adder #(32) adder1_inst (
        .a(pc),
        .b(32'b001),
        .y(pcplus4)
    );

    // Sumador PC+8
    adder #(32) adder2_inst (
        .a(pcplus4),
        .b(32'b001),
        .y(pcplus8)
    );

    // Multiplexor E
    mux_parametrizable mux_e (
        .input1(pcplus4),
        .input2(ra4),
        .select(pcsrc),
        .final_output(ra5)
    );

    // Contador de Programa
    pc_mem #(32) pcmem_inst (
        .clk(clk),
        .rst(rst),
        .pcnext(ra5),
        .pc(pc)
    );

endmodule
