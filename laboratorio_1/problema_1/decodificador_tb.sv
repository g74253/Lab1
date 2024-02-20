module decodificador_tb;
	logic[3:0] num;
	logic[6:0] salida; 
	integer i;
	
	decodificador testbench(
		.num(num),
		.salida(salida)
	);
	
	initial begin
		for (i = 0; i<8; i = i+1) begin
			num = i;
			#40;
		end
	end
endmodule