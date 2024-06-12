module control_deco(input logic [1:0]op,
						  input logic [5:0]funct,
						  input logic [3:0]rd,
						  output logic [1:0]flagw,
						  output logic pcs,
						  output logic regw,
						  output logic memw,
						  output logic memtoreg,
						  output logic alusrc,
						  output logic [1:0] immsrc,
						  output logic [1:0]regsrc,
						  output logic [1:0]alucontrol);
						  
	logic branch,aluop;
	
	control_deco_PC_logic cdpl (.rd(rd),
									  .branch(branch),
									  .regw(regw),
									  .pcs(pcs));
									  
	control_deco_main_decoder cdmd (.op(op),
											 .funct5(funct[5]),
											 .funct0(funct[0]),
											 .regw(regw),
											 .memw(memw),
											 .memtoreg(memtoreg),
											 .alusrc(alusrc),
											 .immsrc(immsrc),
											 .regsrc(regsrc),
											 .branch(branch),
											 .aluop(aluop));
											 
	control_deco_alu_decoder cdad (.aluop(aluop),
											.funct(funct),
											.alucontrol(alucontrol),
											.flagw(flagw));					  

endmodule