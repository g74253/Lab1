module imm_unit (input logic [1:0]immsrc,
					  input logic [23:0]inmediato,
					  output logic [31:0]extimm);

logic [7:0] imm8;
logic [3:0] rotate;
logic signed [31:0] extended;	
				  
always @(*) begin
	if (immsrc == 00)begin
		  imm8 = inmediato[7:0];
        rotate = inmediato[11:8] << 1;
        extended = $signed({24'b0, imm8} >> rotate | {imm8, 24'b0} << (32 - rotate));
        
        // Sign extension
        if (imm8[7] == 1'b1) begin
            extimm = {24'hFFFFFF, extended[7:0]};
        end else begin
            extimm = extended;
        end
		
	end
	
	else if (immsrc == 01)begin
		extimm = inmediato[11:0];
		if (inmediato[11] == 1) begin
			extimm[12] = 1;
			extimm[13] = 1;
			extimm[14] = 1;
			extimm[15] = 1;
			extimm[16] = 1;
			extimm[17] = 1;
			extimm[18] = 1;
			extimm[19] = 1;
			extimm[20] = 1;
			extimm[21] = 1;
			extimm[22] = 1;
			extimm[23] = 1;
			extimm[24] = 1;
			extimm[25] = 1;
			extimm[26] = 1;
			extimm[27] = 1;
			extimm[28] = 1;
			extimm[29] = 1;
			extimm[30] = 1;
			extimm[31] = 1;
		end
		
		else (inmediato[11] == 0) begin
			extimm[12] = 0;
			extimm[13] = 0;
			extimm[14] = 0;
			extimm[15] = 0;
			extimm[16] = 0;
			extimm[17] = 0;
			extimm[18] = 0;
			extimm[19] = 0;
			extimm[20] = 0;
			extimm[21] = 0;
			extimm[22] = 0;
			extimm[23] = 0;
			extimm[24] = 0;
			extimm[25] = 0;
			extimm[26] = 0;
			extimm[27] = 0;
			extimm[28] = 0;
			extimm[29] = 0;
			extimm[30] = 0;
			extimm[31] = 0;
		end
	end
	
	else if (immsrc == 10)begin
		extimm = inmediato[23:0];
		if (inmediato[23] == 1) begin
			extimm[23] = 1;
			extimm[24] = 1;
			extimm[25] = 1;
			extimm[26] = 1;
			extimm[27] = 1;
			extimm[28] = 1;
			extimm[29] = 1;
			extimm[30] = 1;
			extimm[31] = 1;
		end
		
		else (inmediato[23] == 0) begin
			extimm[23] = 0;
			extimm[24] = 0;
			extimm[25] = 0;
			extimm[26] = 0;
			extimm[27] = 0;
			extimm[28] = 0;
			extimm[29] = 0;
			extimm[30] = 0;
			extimm[31] = 0;
		end
	end
	
end		
endmodule