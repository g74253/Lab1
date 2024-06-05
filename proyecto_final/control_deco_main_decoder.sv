module control_deco_main_decoder (input logic [1:0]op,
											 input logic funct5,
											 input logic funct0,
											 output logic regw,
											 output logic memw,
											 output logic memtoreg,
											 output logic alusrc,
											 output logic [1:0]immsrc,
											 output logic [1:0]regsrc,
											 output logic aluop);

always @(*)begin

if (op == 00 & funct5 == 0) begin
	branch = 0;
	memtoreg = 0;
	memw = 0;
	alusrc = 0;
	regw = 1;
	regsrc = 00;
	aluop = 1;
	
	end
	
else if (op == 00 & funct5 == 1) begin
	branch = 0;
	memtoreg = 0;
	memw = 0;
	alusrc = 1;
	immsrc = 00;
	regw = 1;
	regsrc = 00;
	aluop = 1;
	
	end
	
else if (op == 01 & funct0 == 0) begin
	branch = 0;
	memw = 1;
	alusrc = 1;
	immsrc = 01;
	regw = 0;
	regsrc = 2;
	aluop = 0;
	
	end
	
else if (op == 01 & funct0 == 1) begin
	branch = 0;
	memtoreg = 1;
	memw = 0;
	alusrc = 1;
	immsrc = 01;
	regw = 1;
	regsrc = 00;
	aluop = 0;
	
	end
	
else if (op == 2) begin
	branch = 1;
	memtoreg = 0;
	memw = 0;
	alusrc = 1;
	immsrc = 2;
	regw = 0;
	regsrc = 01;
	aluop = 0;
	
	end
end											 
											 
endmodule