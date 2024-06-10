module horizontal_counter(
	input logic clk_25MHz, 
	output logic enable_V_Counter,
	output logic [15:0] H_Count_Value);
	

	always@(posedge clk_25MHz) begin
	
		if (H_Count_Value < 799) begin
			H_Count_Value <= H_Count_Value +1;
			enable_V_Counter <= 0;
		end
		else begin
			H_Count_Value <= 0; 
			enable_V_Counter <= 1;
		end
	end
	
	
endmodule
