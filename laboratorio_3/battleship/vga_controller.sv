module vga_controller #(    
	parameter int CELL_HORIZONTAL_LENGHT = 36,  // Tamaño de la matriz horizontal
   parameter int CELL_VERTICAL_LENGHT = 20     // Tamaño de la matriz vertical
)(
	
	input logic clk,rst,
	input logic button,
	output logic Hsynq,
	
	output logic Vsynq,blank, sync,
	output logic [7:0] Red,
	output logic [7:0] Green,
	output logic [7:0] Blue, 
	output logic clk_vga
	);
	
	
int values[CELL_HORIZONTAL_LENGHT*CELL_VERTICAL_LENGHT] ;


   initial begin
        // Llenar el array con un patrón repetido o valores específicos
        int i;
        for (i = 0; i < CELL_HORIZONTAL_LENGHT * CELL_VERTICAL_LENGHT; i++) begin
            // Puedes usar un patrón específico, aquí usamos un ejemplo cíclico de 'A', 'B', 'C', 'D'
            case (i % 43)
					0: values[i] = 8'd65;
					1: values[i] = 8'd66;
					2: values[i] = 8'd67;
					3: values[i] = 8'd68;
					4: values[i] = 8'd69;
					5: values[i] = 8'd70;
					6: values[i] = 8'd71;
					7: values[i] = 8'd72;
					8: values[i] = 8'd73;
					9: values[i] = 8'd74;
					10: values[i] = 8'd75;
					11: values[i] = 8'd76;
					12: values[i] = 8'd77;
					13: values[i] = 8'd78;
					14: values[i] = 8'd79;
					15: values[i] = 8'd80;
					16: values[i] = 8'd81;
					17: values[i] = 8'd82;
					18: values[i] = 8'd83;
					19: values[i] = 8'd84;
					20: values[i] = 8'd85;
					21: values[i] = 8'd86;
					22: values[i] = 8'd87;
					23: values[i] = 8'd88;
					24: values[i] = 8'd89;
					25: values[i] = 8'd90;		
					26: values[i] = 8'd00;		
					27: values[i] = 8'd00;		
					28: values[i] = 8'd00;		
					29: values[i] = 8'd00;	
					30: values[i] = 8'd48;
					31: values[i] = 8'd49;
					32: values[i] = 8'd50;
					33: values[i] = 8'd51;
					34: values[i] = 8'd52;
					35: values[i] = 8'd53;
					36: values[i] = 8'd54;
					37: values[i] = 8'd55;
					38: values[i] = 8'd56;
					39: values[i] = 8'd57;		
					40: values[i] = 8'd00;		
					41: values[i] = 8'd00;		
					42: values[i] = 8'd00;		
					43: values[i] = 8'd00;	

            endcase
        end
    end



logic clk_25M;	
clock_divider VGA_Clock_gen (clk, clk_25M);

always_ff @(posedge ~button) begin


        if(button) begin
			  int i;
			  for (i = 0; i < CELL_HORIZONTAL_LENGHT * CELL_VERTICAL_LENGHT; i++) begin
					// Puedes usar un patrón específico, aquí usamos un ejemplo cíclico de 'A', 'B', 'C', 'D'
					case (i % 2)
						0: values[i] = 8'd65;
						1: values[i] = 8'd66;
						2: values[i] = 8'd67;


					endcase
			  end
		  end

end


vga_drawer #(
        .CELL_HORIZONTAL_LENGHT(CELL_HORIZONTAL_LENGHT),
        .CELL_VERTICAL_LENGHT(CELL_VERTICAL_LENGHT)
    ) vcg (clk_25M, rst, Hsynq, Vsynq, clk_vga, blank, sync, Red, Green, Blue,values); 

	 
	 
endmodule