module vga_controller_final(
	input logic CLK_IN,	// 25 MHz
	input logic RST, 
	output logic o_hsync,      // horizontal sync
   output logic o_vsync,       // vertical sync
   output logic CLK_OUT,
	output logic BLANK, 
	output logic SYNC,
   output logic [7:0] R,
   output logic [7:0] G,
   output logic [7:0] B );

	//parametros horizontales
	parameter int HD = 640; //Horizontal Display
	parameter int HFP = 16;	//Horizontal Front Display
	parameter int HSP = 96; //Horizontal Sync Time 0-96 hihg
	parameter int HBP = 48;	//Horizontal Back Display
	//parametros verticales
	parameter int VD = 480; //Vertical Display
	parameter int VFP = 10;	//Vertical Front Display
	parameter int VSP = 2; 	//vertical Sync Time
	parameter int VBP = 33;	//vertical back Display
	
	logic [7:0] nR;
   logic [7:0] nG;
   logic [7:0] nB;
	

	
	
	int Mat1 [0:4][0:4]= '{
    '{0, 0, 0, 0, 0},
    '{0, 0, 0,0, 0},
    '{1, 0, 0, 0, 0},
    '{0, 0, 13, 3, 3},
    '{9, 0, 0, 2, 2}
};

	int Mat2 [0:4][0:4]= '{
    '{0, 0, 0, 0, 0},
    '{0, 0, 103,103, 103},
    '{9, 0, 0, 0, 0},
    '{0, 0, 0, 0, 0},
    '{12, 12, 0, 0, 0}
};

int SEP_IZQ = 66; // Posición X de inicio de la matriz
int SEP_VERT = 128; // Posición Y de inicio de la matriz
	
	matrixOutlineDrawer matrix_drawer(
		.counterX(counterX),
		.counterY(counterY),
		.R(nR),
		.G(nG),
		.B(nB),
		.matrix(Mat1),
		.matrix2(Mat2)
  );			
  

	
	//outuputs
	
	assign SYNK = 0;
	assign CLK_OUT = CLK_IN;		
		
	logic [9:0]  counterX = 0;
	logic [9:0]  counterY = 0;	

	//Contadore de Posicion
		//Horizontal_position_counter    
		always_ff @(posedge CLK_IN, negedge RST)
		 if (~RST)
			counterX <= 0;
		 else if (CLK_IN)
			if (counterX == (HD + HFP + HSP + HBP - 1))
			  counterX <= 0;
			else
			  counterX <= counterX + 1;
		 
		//Vertical_position_counter
		always_ff @(posedge CLK_IN, negedge RST)
		 if (~RST)
			counterY <= 0;
		 else if (CLK_IN)
			if (counterX == (HD + HFP + HSP + HBP - 1))
			  if (counterY == (VD + VFP + VSP + VBP - 1))
				 counterY <= 0;
			  else
				 counterY <= counterY + 1;
//Sincronizacion Horizontal y Vertical
	  // Sincronizacion Horizontal
	  always_ff @(posedge CLK_IN, negedge RST)
		 if (~RST)
			begin 
			  o_hsync <= 0;
			end
		 else if (CLK_IN)
			begin
			  if((counterX >= (HD + HFP)) && (counterX < HD + HFP + HSP))
				 o_hsync <= 0;
			  else
				o_hsync <= 1;
			end
			
		// Sincronizacion Vertical
		always_ff @(posedge CLK_IN, negedge RST)
		 if (~RST)
			begin
			  o_vsync <= 0;
			end
		 else if (CLK_IN)
			begin
			  if((counterY >= (VD + VFP)) && (counterY < VD + VFP + VSP))
				 o_vsync <= 0;
			  else
				o_vsync <= 1;
			end
//Video en Pantalla
  always_ff @(posedge CLK_IN, negedge RST)
    if (~RST)
      begin
        BLANK <= 0;
      end
    else if (CLK_IN)
      begin
        if(counterX < HD && counterY < VD)
			BLANK <= 1;
        else 
			BLANK <= 0; 
      end
    
  // Dibujar
  always_ff @(posedge CLK_IN, negedge RST)
    if (~RST)
      begin
        R <= 8'b00000000;
        G <= 8'b00000000;
        B <= 8'b00000000;
      end
    else if (CLK_IN)  
      begin 
			
				R <= nR;
				G <= nG;
				B <= nB;
				

		end
		

endmodule 		