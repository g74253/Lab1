module divisor_frecuencia (input logic clk,
									output logic new_clk);

	logic[25:0] divisor = 0;
	logic clk_temp = 0;
	
	always @(posedge clk) begin
		if(divisor == /*50000000*/ 1000) begin
			divisor = 0;
			clk_temp = ~clk_temp;
		end else begin
			divisor = divisor + 1;
		end
	end
	
	assign new_clk = clk_temp;

endmodule