module control_unit (input logic cond [31:28],
							input logic op [27:26],
							input logic funct [25:20],
							input logic rd [15:12]),
							input logic flags,
							output logic pcsrc,
							output logic memtoreg,
							output logic memwrite,
							output logic alucontrol,
							output logic alusrc,
							output logic immsrc,
							output logic regwrite
							output logic regsrc;

endmodule