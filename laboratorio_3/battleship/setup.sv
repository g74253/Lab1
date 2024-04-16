module setup(input logic en_setup,
				input logic boton_arriba,
				input logic boton_abajo,
				input logic boton_izquierda,
				input logic boton_derecha,
				input logic [2:0] cant_barco,
				input logic rst,
				input logic boton_colocar,
				output int matrix[4:0][4:0],
				output logic end_setup);
				
	int temp[4:0][4:0];	
	int temp_pos[1:0];
	logic [2:0] temp_cantship;
				
	always @(posedge boton_arriba,
				posedge boton_abajo,
				posedge boton_izquierda,
				posedge boton_derecha,
				posedge boton_colocar,
				posedge rst) begin
				
		if (rst) begin
			temp = '{'{0,0,0,0,0},'{0,0,0,0,0},'{0,0,0,0,0},'{0,0,0,0,0},'{0,0,0,0,0}};
			temp_pos[0] = 4;//x
			temp_pos[1] = 4;//y
			temp_cantship = cant_barco;
		end
		else if (en_setup) begin
			if(boton_arriba && temp_pos[1] != 4) begin
				temp_pos[1] = temp_pos[1]+1;
			end
			else if(boton_abajo && temp_pos[1] != 0) begin
				temp_pos[1] = temp_pos[1]-1;
			end
			else if(boton_izquierda && temp_pos[0] != 4 ) begin
				temp_pos[0] = temp_pos[0]+1;
			end
			else if(boton_derecha && temp_pos[0] != 0) begin
				temp_pos[0] = temp_pos[0]-1;
			end
			else if(boton_colocar) begin
				case (temp_cantship)
					3'b101: 	begin
									if (temp_pos[0] == 4) begin
										temp_cantship = temp_cantship -1;
										temp[temp_pos[1]][temp_pos[0]] = 5;
										temp[temp_pos[1]][temp_pos[0]-1] = 5;
										temp[temp_pos[1]][temp_pos[0]-2] = 5;
										temp[temp_pos[1]][temp_pos[0]-3] = 5;
										temp[temp_pos[1]][temp_pos[0]-4] = 5;
									end
								end
					3'b100: 	begin
									if ((temp_pos[0] == 4 || temp_pos[0] == 3) && temp[temp_pos[1]][temp_pos[0]] !=5) begin
										temp_cantship = temp_cantship -1;
										temp[temp_pos[1]][temp_pos[0]] = 4;
										temp[temp_pos[1]][temp_pos[0]-1] = 4;
										temp[temp_pos[1]][temp_pos[0]-2] = 4;
										temp[temp_pos[1]][temp_pos[0]-3] = 4;
									
									end
								end
					3'b011: 	begin
									if ((temp_pos[0] == 4 || temp_pos[0] == 3 || temp_pos[0] == 2)&& temp[temp_pos[1]][temp_pos[0]+1] ==0) begin
										temp_cantship = temp_cantship -1;
										temp[temp_pos[1]][temp_pos[0]] = 3;
										temp[temp_pos[1]][temp_pos[0]-1] = 3;
										temp[temp_pos[1]][temp_pos[0]-2] = 3;
									end
								end
					3'b010: 	begin
								if ((temp_pos[0] == 4 || temp_pos[0] == 3|| temp_pos[0] == 2 || temp_pos[0] == 1) && (temp[temp_pos[1]][temp_pos[0]+1] ==0 ) && temp[temp_pos[1]][temp_pos[0]]==0 ) begin
										temp_cantship = temp_cantship -1;
										temp[temp_pos[1]][temp_pos[0]] = 2;
										temp[temp_pos[1]][temp_pos[0]-1] = 2;
									end
								end
					3'b001: 	begin
					if ((temp_pos[0] == 4 || temp_pos[0] == 3 || temp_pos[0] == 3 || temp_pos[0] == 2 || temp_pos[0] == 1 || temp_pos[0] == 0 )&& temp[temp_pos[1]][temp_pos[0]] ==0) begin
										temp_cantship = temp_cantship -1;
										temp[temp_pos[1]][temp_pos[0]] = 1;
								end
								end
				endcase
			end
		end
	end
	
	assign end_setup = (temp_cantship ==0);
	assign matrix = temp;
	
endmodule