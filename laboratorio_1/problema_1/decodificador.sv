module decodificador (input logic [3:0] num,
							 output logic [6:0] salida);
	always @ (num) begin
		case(num)
			4'b0000: salida = 7'b0000001; 
			4'b0001: salida = 7'b1001111; 
			4'b0010: salida = 7'b0010010; 
			4'b0011: salida = 7'b0000110; 
			4'b0100: salida = 7'b1001100; 
			4'b0101: salida = 7'b0100100; 
			4'b0110: salida = 7'b0100000; 
			4'b0111: salida = 7'b0001110; 
			4'b1000: salida = 7'b0000000; 
			4'b1001: salida = 7'b0000100; 
			default: salida = 7'b1111111;
		endcase
	end
endmodule	