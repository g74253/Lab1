module fsm(input logic clk, 
			  input logic rst, 
			  input logic iniciar,
			  input logic end_setup,
			  input logic end_attack,
			  input logic end_attack_pc,
			  input logic pc_life,
			  input logic player_life,
			  input logic timeout, 
			  output logic en_setup,
			  output logic en_attack,
			  output logic en_check_pc_life,
			  output logic en_check_setup_random,
			  output logic en_attack_pc,
			  output logic en_check_attack_random,
			  output logic en_check_player_life,
			  output logic gameover );

logic [3:0] state, next_state;

//actual state logic
always_ff @ (posedge clk or posedge rst)
	if (rst) state = 4'b0000;
	else
		state = next_state;

//next state logic
always_comb
	case(state)
		4'b0000:if (iniciar) begin 
						next_state = 4'b0001;
					end else begin
						next_state = 4'b0000;
					end
		4'b0001: if (end_setup) begin 
						next_state = 4'b0011;
					end else begin
						next_state = 4'b0010;
					end
		4'b0010:next_state = 4'b0001;
		4'b0011:if (end_attack) begin 
						next_state = 4'b0101;
					end else begin
						next_state = 4'b0100;
					end
		4'b0100:if (timeout) begin 
						next_state = 4'b0110;
					end else begin
						next_state = 4'b0011;
					end
		4'b0101:if (pc_life == 0) begin 
						next_state = 4'b1001;
					end else begin
						next_state = 4'b0110;
					end
		4'b0110:if (end_attack_pc) begin 
						next_state = 4'b1000;
					end else begin
						next_state = 4'b0111;
					end
		4'b0111:next_state = 4'b0110;
		4'b1000:if (player_life == 0) begin 
						next_state = 4'b1001;
					end else begin
						next_state = 4'b0011;
					end
		4'b1001:next_state = 4'b1001;
	endcase	
//output logic 

assign en_setup = (state == 4'b0001 || state == 4'b0010);
assign en_attack = (state == 4'b0011 || state == 4'b0100);
assign en_check_pc_life = (state == 4'b0101);
assign en_check_setup_random = state == 4'b0010;
assign en_attack_pc = (state == 4'b0110 || state == 4'b0111);
assign en_check_attack_random = state == 4'b0111;
assign en_check_player_life = (state == 4'b1000);
assign gameover = (state == 4'b1001);


endmodule