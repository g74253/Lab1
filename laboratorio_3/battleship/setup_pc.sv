module setup_pc (input logic en_check_setup_random,
						input logic rand_x,
						input logic rand_y,
						input logic [2:0] cant_barco,
						input logic rst,
						output int matrix[4:0][4:0],
						output logic end_setup);

	int temp[4:0][4:0];
	logic [2:0] temp_cantship;
	
	always @(posedge en_check_setup_random,
				posedge rst) begin
		if (rst) begin
			temp = '{'{0,0,0,0,0},'{0,0,0,0,0},'{0,0,0,0,0},'{0,0,0,0,0},'{0,0,0,0,0}};
			temp_cantship = cant_barco;
		end else if (en_check_setup_random) begin
			case (temp_cantship)
				3'b101: 	begin
								temp_cantship = temp_cantship -1;
								temp[rand_y][4] = 5;
								temp[rand_y][3] = 5;
								temp[rand_y][2] = 5;
								temp[rand_y][1] = 5;
								temp[rand_y][0] = 5;
							end
				3'b100: 	begin
								if ((rand_x == 4 || rand_x == 3) && temp[rand_y][rand_x] !=5) begin
									temp_cantship = temp_cantship -1;
									temp[rand_y][rand_x] = 4;
									temp[rand_y][rand_x-1] = 4;
									temp[rand_y][rand_x-2] = 4;
									temp[rand_y][rand_x-3] = 4;
								
								end
							end
				3'b011: 	begin
								if ((rand_x == 4 || rand_x == 3 || rand_x == 2)&& temp[rand_y][rand_x+1] ==0) begin
									temp_cantship = temp_cantship -1;
									temp[rand_y][rand_x] = 3;
									temp[rand_y][rand_x-1] = 3;
									temp[rand_y][rand_x-2] = 3;
								end
							end
				3'b010: 	begin
								if ((rand_x == 4 || rand_x == 3|| rand_x == 2 || rand_x == 1) && (temp[rand_y][rand_x+1] ==0 ) && temp[rand_y][rand_x]==0 ) begin
									temp_cantship = temp_cantship -1;
									temp[rand_y][rand_x] = 2;
									temp[rand_y][rand_x-1] = 2;
								end
							end
				3'b001: 	begin
								if ((rand_x == 4 || rand_x == 3 || rand_x == 3 || rand_x == 2 || rand_x == 1 || rand_x == 0 )&& temp[rand_y][rand_x] ==0) begin
									temp_cantship = temp_cantship -1;
									temp[rand_y][rand_x] = 1;
								end
							end
			endcase
		end
	end
	
	assign end_setup = (temp_cantship ==0);
	assign matrix = temp;


endmodule