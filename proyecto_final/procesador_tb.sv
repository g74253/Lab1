`timescale 1ps/1ps
`default_nettype none
`define TESTING

module procesador_tb ();

	logic clk;
	logic rst;
	logic wren_b;
	logic [31:0] address;
	logic [7:0] q_b;
	
	procesador pro (.clk(clk), 
						.rst(rst),
						.wren_b(wren_b),
						.address(address),
						.q_b(q_b));
					
	
	initial begin
		wren_b = 0;
		address = 100;
		rst <= 1; # 22; rst <= 0;
	end
	always begin
		clk <= 1; # 10; clk <= 0; # 10;
	end

	always @(negedge clk) begin
		if(address === 100 & q_b === 7) begin
			$display("Simulation succeeded");
			$stop; 
		end else if (address !== 96) begin
			$display("Simulation failed");
		end
	end
endmodule