module selectRowCol(input logic ena_rowCol,
				input logic boton_arriba,
				input logic boton_abajo,
				input logic boton_izquierda,
				input logic boton_derecha,
				input logic rst,
				input logic boton_colocar,
				output int row,
				output int col,
				output end_rowCol);			
	

	always @(posedge boton_arriba,
				posedge boton_abajo,
				posedge boton_izquierda,
				posedge boton_derecha,
				posedge boton_colocar,
				posedge rst) begin
				
		if (rst) begin
			row = 0;
	      col = 0;	
		end
		else if (ena_rowCol) begin
			if(boton_arriba && col != 4) begin
				col = col+1;
			end
			else if(boton_abajo && col!= 0) begin
				col = col-1;
			end
			else if(boton_izquierda && row != 4 ) begin
				row = row+1;
			end
			else if(boton_derecha && row!= 0) begin
				row = row-1;
			end
			else if(boton_colocar) begin
				end_rowCol = 1;
			end
		end
	end
	
	
endmodule