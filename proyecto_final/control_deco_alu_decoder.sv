module control_deco_alu_decoder (input logic aluop,
											input logic [4:0]funct,
											output logic [1:0]alucontrol,
											output logic [1:0]flagw);

							
always @(*)begin

if (aluop == 0)begin
	alucontrol = 00;
	flagw = 0;
	end
	
else if (aluop == 1 & funct[4:1] == 4 & funct[0] ==0)begin
	alucontrol = 00;
	flagw = 0;
	end
	
else if (aluop == 1 & funct[4:1] == 4 & funct[0] ==1)begin
	alucontrol = 00;
	flagw = 3;
	end
	
else if (aluop == 1 & funct[4:1] == 2 & funct[0] ==0)begin
	alucontrol = 01;
	flagw = 0;
	end
	
else if (aluop == 1 & funct[4:1] == 2 & funct[0] ==1)begin
	alucontrol = 01;
	flagw = 3;
	end
	
else if (aluop == 1 & funct[4:1] == 0 & funct[0] ==0)begin
	alucontrol = 2;
	flagw = 0;
	end
	
else if (aluop == 1 & funct[4:1] == 0 & funct[0] ==1)begin
	alucontrol = 2;
	flagw = 2;
	end
	
else if (aluop == 1 & funct[4:1] == 12 & funct[0] ==0)begin
	alucontrol = 3;
	flagw = 0;
	end
	
else if (aluop == 1 & funct[4:1] == 12 & funct[0] ==1)begin
	alucontrol = 3;
	flagw = 2;
	end

end
endmodule