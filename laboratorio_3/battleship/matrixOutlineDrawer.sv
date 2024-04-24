module matrixOutlineDrawer(
    input wire [9:0] counterX,
    input wire [9:0] counterY,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B,
    input int  matrix[4:0][4:0],
	 input int  matrix2[4:0][4:0]
);

// Parámetros

parameter SEP_IZQ = 66; // Posición X de inicio de la matriz
parameter SEP_VERT = 128; // Posición Y de inicio de la matriz
parameter SEP_IZQ2= 350;
parameter CELL_SIZE = 44; // Tamaño de la matriz

integer x_coordinate;
integer y_coordinate;
integer relativeXPosition;
integer relativeYPosition;
integer internalMargin = 5;
int currentCasillaValue;

always @* begin

      if (counterX >= SEP_IZQ && counterX <= SEP_IZQ + CELL_SIZE *5) begin
            if ( counterY >= SEP_VERT && counterY <= SEP_VERT+ CELL_SIZE*5) begin
           
                //Bloques
                if (counterX > SEP_IZQ && counterX < SEP_IZQ + CELL_SIZE * 5  && counterY > SEP_VERT && counterY < SEP_VERT + CELL_SIZE * 5) begin
                    x_coordinate = (counterX - SEP_IZQ) / CELL_SIZE;
                    y_coordinate = (counterY - SEP_VERT) / CELL_SIZE;

            
					relativeXPosition = counterX - SEP_IZQ - x_coordinate * CELL_SIZE;
					relativeYPosition = counterY - SEP_VERT - y_coordinate * CELL_SIZE;
					if (relativeXPosition >= internalMargin && relativeXPosition <= CELL_SIZE - internalMargin ) begin
							if(relativeYPosition >= internalMargin && relativeYPosition <= CELL_SIZE - internalMargin) begin
									currentCasillaValue= matrix[y_coordinate][x_coordinate];
									if (currentCasillaValue > 100) begin
										// Casilla con valor mayor que 10 (Marrón oscuro)
										R <= 8'b01111000;
										G <= 8'b00011000;
										B <= 8'b00000010;
									end
									else begin

										// Casillas vacias (Gris)
										if (currentCasillaValue ==9) begin
											R <= 8'b01111110;
											G <= 8'b01111110;
											B <= 8'b01111110;
										end

										// Casillas normales (Azul claro)
										if (currentCasillaValue > 0 && currentCasillaValue <= 5) begin
											R <= 8'b01101001;
											G <= 8'b01101111;
											B <= 8'b11111111;
										end
										// Jugador atacado (Rojo)
										else if (currentCasillaValue > 10  && currentCasillaValue < 20) begin
											R <= 8'b11111111;
											G <= 8'b00000000;
											B <= 8'b00000000;
										end
										// Disparo acertado (Verde azulado)
										else if (currentCasillaValue == 7) begin
											R <= 8'b10000100;
											G <= 8'b10111000;
											B <= 8'b10000011;
										end

										else  begin
											R <= 8'b00000000;
											G <= 8'b00000000;
											B <= 8'b00000000;
										end
									end


								end   else begin
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
            

            
                if ((counterX-SEP_IZQ) % CELL_SIZE == 0 || (counterY-SEP_VERT) % CELL_SIZE == 0)begin
                     R <= 8'b11100101;
                     G <= 8'b10011100;
                     B <= 8'b00010100;
                  end

                end
            else begin
                R <= 8'b00000000;
                G <= 8'b00000000;
                B <= 8'b00000000;
            end
      end
      else begin
            R <= 8'b00000000;
            G <= 8'b00000000;
            B <= 8'b00000000;
        end
    


    
    
    
    
    
     //Matriz 2
         if (counterX >= SEP_IZQ2 && counterX <= SEP_IZQ2 + CELL_SIZE *5) begin
            if ( counterY >= SEP_VERT && counterY <= SEP_VERT+ CELL_SIZE*5) begin
           
				//Bloques
                if (counterX > SEP_IZQ2 && counterX < SEP_IZQ2 + CELL_SIZE * 5  && counterY > SEP_VERT && counterY < SEP_VERT + CELL_SIZE * 5) begin
                    x_coordinate = (counterX - SEP_IZQ2) / CELL_SIZE;
                    y_coordinate = (counterY - SEP_VERT) / CELL_SIZE;


					relativeXPosition = counterX - SEP_IZQ2 - x_coordinate * CELL_SIZE;
					relativeYPosition = counterY - SEP_VERT - y_coordinate * CELL_SIZE;
					if (relativeXPosition >= internalMargin && relativeXPosition <= CELL_SIZE - internalMargin ) begin
							if(relativeYPosition >= internalMargin && relativeYPosition <= CELL_SIZE - internalMargin) begin
									currentCasillaValue= matrix2[y_coordinate][x_coordinate];
									if (currentCasillaValue > 100) begin
										// Casilla con valor mayor que 10 (Verde claro) barco hundido
										R <= 8'b01010001;
										G <= 8'b11111111;
										B <= 8'b01001101;
									end
									else begin

										// Casillas vacias (Gris)  disparo fallido
										if (currentCasillaValue ==9) begin
											R <= 8'b01111110;
											G <= 8'b01111110;
											B <= 8'b01111110;
										end


										// Jugador atacado (Verde)
										else if (currentCasillaValue > 10  && currentCasillaValue < 20) begin
											R <= 8'b10000100;
											G <= 8'b10111000;
											B <= 8'b10000011;
										end


										else  begin
											R <= 8'b00000000;
											G <= 8'b00000000;
											B <= 8'b00000000;
										end
									end


								end   else begin
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


                if ((counterX-SEP_IZQ2) % CELL_SIZE == 0 || (counterY-SEP_VERT) % CELL_SIZE == 0)begin
                     R <= 8'b11100101;
                     G <= 8'b10011100;
                     B <= 8'b00010100;
                  end


            end
            else begin
                R <= 8'b00000000;
                G <= 8'b00000000;
                B <= 8'b00000000;
            end
      end

    

    

end

endmodule
