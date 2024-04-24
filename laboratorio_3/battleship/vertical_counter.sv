module vertical_counter(
	input logic clk_25MHz, 
	input logic [15:0] counterX,
	output logic [15:0] V_Count_Value);
	

	always@(posedge clk_25MHz) begin
		if (counterX == 799) begin
			if (V_Count_Value < 525) 
				V_Count_Value <= V_Count_Value +1;
			else V_Count_Value <= 0; 
		end
	end
endmodule	