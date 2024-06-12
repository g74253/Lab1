module condition_check (input logic [3:0]cond,
								input logic [1:0]flags32,
								input logic [1:0]flags10,
								output logic condex);
//flag neg esta en 0
// flag cero esta en 1
// flag carry esta en 2
//flag desbordamiento esta en 3

always @(*)begin
	case(cond)
	4'b0000: condex = flags10[1];
	4'b0001: condex = !flags10[1];
	4'b0010: condex = flags32[0];
	4'b0011: condex = !flags32[0];
	4'b0100: condex = flags10[0];
	4'b0101: condex = !flags10[0];
	4'b1110: condex = 1'b1;
	default: condex = 1'bx;
	endcase
end	
endmodule