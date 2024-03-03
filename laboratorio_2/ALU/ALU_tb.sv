module ALU_tb;

	logic [3:0]entrada1=0;  
   logic [3:0] entrada2=0;
   logic [3:0] selector=0; 
   logic [6:0]salida;
	logic carry;
	logic cero;
	
	ALU_deco ALU (entrada1,entrada2,selector,salida,carry,cero);
	
	initial begin
		#5;
		selector=0;
		entrada1=2;
		entrada2=4;
		#40;
	end
endmodule