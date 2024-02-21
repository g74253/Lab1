module ContadorNBits #(parameter N=6)(input logic clk, rst, output logic [N-1:0] out);

always @(negedge clk, posedge rst) begin

	if (rst) out <= 0;
	else out = out + 1;

end
endmodule