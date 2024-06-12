module procesador (input logic clk,
						 input logic rst,
						 input logic wren_b,
						 output logic Hsynq,
					  	 output logic Vsynq, blank, sync,
						 output logic [7:0] Green,
						 output logic [7:0] Red,
						 output logic [7:0]q_b,
						 output logic [7:0] Blue,
						 input logic [31:0]address,
						 
						 output logic clk_vga);
	logic [31:0]pc;							 
	logic [31:0]instr;				
	inst_mem mem (.address(pc),
					  .clock(clk),
					  .q(instr));
					  
	logic [3:0]aluflags;	
	logic pcsrc;
	logic memtoreg;
	logic memwrite;
	logic [1:0]alucontrol;
	logic	alusrc;
	logic	[1:0]immsrc;
	logic	regwrite;
	logic	[1:0]regsrc;
	logic [31:0]pcplus4;	
	logic [31:0]pcplus8;	
	
	logic [3:0]ra4;
	
	control_unit control (.cond(instr[31:28]),
								 .op(instr[27:26]),
								 .funct(instr[25:20]),
								 .rd(instr[15:12]),
								 .aluflags(aluflags),
								 .clk(clk),
								 .pcsrc(pcsrc),
								 .memtoreg(memtoreg),
								 .memwrite(memwrite),
								 .alucontrol(alucontrol),
								 .alusrc(alusrc),
								 .immsrc(immsrc),
								 .regwrite(regwrite),
								 .regsrc(regsrc));
								 
	logic [31:0]extimm;
	imm_unit inmediat (.immsrc(immsrc),
					       .inmediato(instr[23:0]),
					       .extimm(extimm));
							 
	logic [3:0]ra1;						 
	mux_parametrizable mux_a (.input1(instr[19:16]),
									  .input2(4'b1111),
									  .select(regsrc[0]),
									  .final_output(ra1));
									  
	logic [3:0]ra2;						 
	mux_parametrizable mux_b (.input1(instr[3:0]),
									  .input2(instr[15:12]),
									  .select(regsrc[1]),
									  .final_output(ra2));
	logic [15:0]rd1;
	logic [15:0]rd2;
	registro_unit regist(.clk(clk),
							   .a1(ra1),
							   .a2(ra2),
							   .a3(instr[15:2]),
							   .wd3(ra4),
							   .r15(pcplus8),
							   .we3(regwrite),
								.rd1(rd1),
								.rd2(rd2));
								
	logic [3:0]ra3;						 
	mux_parametrizable mux_c (.input1(rd2[0]),
									  .input2(extimm),
									  .select(alusrc),
									  .final_output(ra3));
									  
									  

	logic [7:0]readata;								  
	data_mem datmem (.address_a(aluresult),
						  .address_b(address),
						  .clock(clk),
						  .data_a(rd2),
						  .data_b(),
						  .wren_a(memwrite),
						  .wren_b(wren_b),
						  .q_a(readata),
						  .q_b(q_b));
						  
						
										  
								  
									  
						  
	logic [31:0]aluresult;								  
	ALU_case alu (.entrada1(rd1),  
					  .entrada2(ra3), 
					  .alucontrol(alucontrol), 
					  .resultado(aluresult),
					  .carry(aluflags[2]), 
					  .cero(aluflags[1]),
					  .negativo(aluflags[0]),
					  .desbordamiento(aluflags[3]));
	
							 
	mux_parametrizable mux_d (.input1(readata),
									  .input2(aluresult),
									  .select(memtoreg),
									  .final_output(ra4));	
									  
						  
	adder #(32)adder1 (.a(pc), 
							 .b(32'b001), 
							 .y(pcplus4));
							
	adder #(32)adder2 (.a(pcplus4), 
							 .b(32'b001), 
							 .y(pcplus8));

	logic [31:0]ra5;						 
	mux_parametrizable mux_e (.input1(pcplus4),
									  .input2(ra4),
									  .select(pcsrc),
									  .final_output(ra5));	
	pc_mem #(32)pcmem (.clk(clk),
							.rst(rst),
							.pcnext(ra5),
							.pc(pc));
					  
								  
						 
endmodule