module contador6Bits (
    input logic clk, // Reloj de entrada
    input logic rst, // Señal de reset
    output logic [6:0] display1, // Display de 7 segmentos 1
    output logic [6:0] display2  // Display de 7 segmentos 2
);
    logic [5:0] outC; // Contador de 6 bits
    logic pulse_0_5_sec; // Pulso cada 0.5 segundos

//   decodificador led1 (
//        .c(display1), // Los 4 bits menos significativos del contador para el primer display
//        .e(4'b0001)
//    );
	 

    ClockDivider clock_divider (
        .clk(clk),
        .pulse_0_5_sec(pulse_0_5_sec)
    );

    ContadorNBits #(6) contador6b (
        .clk(pulse_0_5_sec),
        .out(outC)
    ); // Instancia del contador

    decodificador led1 (
        .c(display1), // Los 4 bits menos significativos del contador para el primer display
        .e(outC[3:0])
    );
    decodificador led2 (
        .c(display2), // Los 2 bits más significativos del contador para el segundo display
        .e({2'b0,outC[5:4]})
    );

endmodule

module ClockDivider (
    input logic clk, // Reloj de entrada
    
    output logic pulse_0_5_sec // Pulso cada 0.5 segundos
);
    reg [24:0] counter_0_5_sec; // Contador para generar un pulso cada 0.5 segundos
    
    always @(posedge clk) begin
		  if (counter_0_5_sec == 25000000) begin // 50 MHz * 0.5 segundos
            counter_0_5_sec <= 0;
            pulse_0_5_sec <= 1; // Generar un pulso cada 0.5 segundos
        end else begin
            counter_0_5_sec <= counter_0_5_sec + 1;
            pulse_0_5_sec <= 0;
        end
    end
endmodule

module ContadorNBits #(parameter N=6) (
    input logic clk, // Reloj de entrada

    output logic [N-1:0] out // Salida del contador
);
    always @(posedge clk) begin
		
            out = out + 1; // Incrementar el contador en cada flanco de subida del reloj
        
    end
endmodule


