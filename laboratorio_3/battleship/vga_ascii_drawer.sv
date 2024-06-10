module vga_ascii_drawer #(    
	parameter int CELL_HORIZONTAL_LENGHT = 36,  // Tamaño de la matriz horizontal
   parameter int CELL_VERTICAL_LENGHT = 20     // Tamaño de la matriz vertical
)(
    input wire [9:0] counterX,
    input wire [9:0] counterY,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B,
	 input int values[CELL_HORIZONTAL_LENGHT*CELL_VERTICAL_LENGHT],
	 input logic RST
	 
);

    // Parámetros
    parameter SEP_IZQ = 50;           // Posición X de inicio de la matriz
    parameter SEP_VERT = 60;          // Posición Y de inicio de la matriz
    parameter CELL_SIZE = 8;         // Tamaño de la matriz

	 //pattern = '{8'b00110000, 8'b01111000, 8'b11001100, 8'b11001100, 8'b11111100, 8'b11001100, 8'b11001100, 8'b00000000};

    integer x_coordinate;
    integer y_coordinate;
    integer relativeXPosition;
    integer relativeYPosition;
    integer internalMargin = 0;
    int AsciiCodeRelativeToCellPosition;
	 logic currentPixelValue;
	 logic [7:0] pattern[0:7];
	 
	 
	 ascii_decoder asciiDecoder(
		  .ascii_code(values[AsciiCodeRelativeToCellPosition]),
		  .pattern (pattern ),
	 );
	 
	 
	 
    always @* begin
	 
			
			
        if (counterX >= SEP_IZQ && counterX <= SEP_IZQ + CELL_SIZE * CELL_HORIZONTAL_LENGHT) begin
            if (counterY >= SEP_VERT && counterY <= SEP_VERT + CELL_SIZE * CELL_VERTICAL_LENGHT) begin
                // Bloques
                if (counterX > SEP_IZQ && counterX < SEP_IZQ + CELL_SIZE * CELL_HORIZONTAL_LENGHT && counterY > SEP_VERT && counterY < SEP_VERT + CELL_SIZE * CELL_VERTICAL_LENGHT) begin
                    x_coordinate = (counterX - SEP_IZQ) / CELL_SIZE;
                    y_coordinate = (counterY - SEP_VERT) / CELL_SIZE;
                    relativeXPosition = counterX - SEP_IZQ - x_coordinate * CELL_SIZE;
                    relativeYPosition = counterY - SEP_VERT - y_coordinate * CELL_SIZE;
						  
						  
						  AsciiCodeRelativeToCellPosition = values[x_coordinate + y_coordinate* CELL_HORIZONTAL_LENGHT];
                    
                    if (relativeXPosition >= internalMargin && relativeXPosition <= CELL_SIZE - internalMargin) begin
                        if (relativeYPosition >= internalMargin && relativeYPosition <= CELL_SIZE - internalMargin) begin
									 currentPixelValue = pattern[relativeYPosition][7 - relativeXPosition]; // Invertir el orden de bits
									 if (currentPixelValue) begin
										 R = 8'b01111000;
										 G = 8'b11111000;
										 B = 8'b11100010;
									 end else begin
										 R <= 8'b00000000;
										 G <= 8'b00000000;
										 B <= 8'b00000000;
									 end
									 
									 
									 
									 
									 
                        end else begin
                            R <= 8'b00000000;
                            G <= 8'b00000000;
                            B <= 8'b00000000;
                        end
                    end else begin
                        R <= 8'b00000000;
                        G <= 8'b00000000;
                        B <= 8'b00000000;
                    end
                end
                
           
            end else begin
                R <= 8'b00000000;
                G <= 8'b00000000;
                B <= 8'b00000000;
            end
        end else begin
            R <= 8'b00000000;
            G <= 8'b00000000;
            B <= 8'b00000000;
        end
    end

endmodule
