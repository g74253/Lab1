module control_unit (input logic[3:0]cond,
							input logic [1:0]op,
							input logic[5:0]funct,
							input logic [3:0]rd,
							input logic [3:0]aluflags,
							input logic clk,
							output logic pcsrc,
							output logic memtoreg,
							output logic memwrite,
							output logic[1:0]alucontrol,
							output logic alusrc,
							output logic [1:0]immsrc,
							output logic regwrite,
							output logic [1:0]regsrc);
							
	logic [1:0]flagw;
	logic pcs,regw,memw;
	
	control_deco cd (.op(op),
						  .funct(funct),
						  .rd(rd),
						  .flagw(flagw),
						  .pcs(pcs),
						  .regw(regw),
						  .memw(memw),
						  .memtoreg(memtoreg),
						  .alusrc(alusrc),
						  .immsrc(immsrc),
						  .regsrc(regsrc),
						  .alucontrol(alucontrol));
	
	conditional_logic cl (.cond(cond),
								 .aluflags(aluflags),
								 .clk(clk),
								 .flagw(flagw),
								 .pcs(pcs),
								 .regw(regw),
								 .memw(memw),
								 .pcsrc(pcsrc),
								 .regwrite(regwrite),
								 .memwrite(memwrite));

endmodule