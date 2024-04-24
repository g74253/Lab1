module random_func (input logic clk,
				  input logic rst,
				  output logic[2:0]  random ); 
				  
	always @ (posedge clk, posedge rst)
		if (rst)
			random <= 3'h4; //iniciador rand
	else
		random <= {random[1:0], (random[2] ^ random[1])};
		
endmodule
				  