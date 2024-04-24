module shipBlockDrawer(
    input wire [9:0] counterX,
    input wire [9:0] counterY,
    output reg [7:0] R,
    output reg [7:0] G,
    output reg [7:0] B,
	 output int  matrix[4:0][4:0]
);

// Parámetros
parameter WIDTH = 224; // Ancho de la línea
parameter HEIGHT = 224;   // Alto de la línea
parameter SEP_IZQ = 66; // Posición X de inicio de la matriz
parameter SEP_VERT = 128; // Posición Y de inicio de la matriz
parameter SEP_IZQ2= 350;
parameter MATRIX_SIZE = 5; // Tamaño de la matriz
parameter CELL_SIZE = 44; // Tamaño de la matriz
parameter LINE_WIDTH_SIZE = 2; // Tamaño de la matrizX
integer x_coordinate;
integer y_coordinate;
integer relativeXPosition;
integer relativeYPosition;
always @* begin
    integer internalMargin = 5;
    if (counterX >= SEP_IZQ && counterX < SEP_IZQ + CELL_SIZE * 5 &&
        counterY >= SEP_VERT && counterY < SEP_VERT + CELL_SIZE * 5) begin
         x_coordinate = (counterX - SEP_IZQ) / CELL_SIZE;
         y_coordinate = (counterY - SEP_VERT) / CELL_SIZE;

        if (matrix[y_coordinate][x_coordinate] == 6) begin
            relativeXPosition = counterX - SEP_IZQ - x_coordinate * CELL_SIZE;
            relativeYPosition = counterY - SEP_VERT - y_coordinate * CELL_SIZE;
            if (relativeXPosition >= internalMargin && relativeXPosition <= CELL_SIZE - internalMargin )begin
						if(relativeYPosition >= internalMargin && relativeYPosition <= CELL_SIZE - internalMargin) begin
						 R <= 8'b11100101;
						 G <= 8'b10011100;
						 B <= 8'b00010100;
						end  

            end 
        end 

	 end

end

endmodule
