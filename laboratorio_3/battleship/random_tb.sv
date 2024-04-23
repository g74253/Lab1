module random_tb;

	logic clk;  
   logic rst;
	logic [2:0] random;
	
	
	random_func prueba_rndom (clk,rst,random);
	
	always begin
		#10 clk = ~clk;

	end
	initial begin
		rst = 1;
		clk = 0;
		#10;
		rst = 0;
		#400;
		$stop;
	end
endmodule