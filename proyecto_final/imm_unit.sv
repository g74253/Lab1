module imm_unit (input logic [1:0]immsrc,
					  input logic [23:0]inmediato,
					  output logic [31:0]extimm);
				  
always_comb begin
		case(immsrc)
			2'b00: extimm = {24'b0, inmediato[7:0]};
			2'b01: extimm = {20'b0, inmediato[11:0]};
			2'b10: extimm = {{6{inmediato[23]}}, inmediato[23:0], 2'b00};
			default: extimm = 32'bx;
endcase
	end	
endmodule