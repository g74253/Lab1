module contador (input logic en_attack,
					  input logic clk,
					  output logic timeout);
						
						
	
	int temp = 0;
	always @ (posedge clk) begin
		if (en_attack) begin
			temp = temp + 1;
		end
		else begin
			temp = 0;
		end
	end
	
	assign timeout = (temp>=15);
						
endmodule