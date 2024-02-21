module contador6Bits(input logic clk,
							input logic rst,
							output logic [6:0] display1,
							output logic [6:0] display2);
							
							logic [5:0] outC;
							
		ContadorNBits #(6) contador6b(clk,rst,outC);
		decodificador led1(outC[3:0],display1);
		decodificador led2({2'b0,outC[5:4]},display2);

endmodule
							