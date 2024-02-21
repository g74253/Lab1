module testbenchContadorNBits;

logic clk, rst;


logic [1:0] numero2Bits;
logic [3:0] numero4Bits;
logic [5:0] numero6Bits;

always #5 clk = ~clk;

ContadorNBits #(2) contador2bits(clk,rst,numero2Bits);
ContadorNBits #(4) contador4bits(clk,rst,numero4Bits);
ContadorNBits #(6) contador6bits(clk,rst,numero6Bits);

initial begin 

$monitor ("[%0tns] clk=%0b rst=%0b numero2Bits=0x%0h numero4Bits=0x%0h numero6Bits=0x%0h", 
			$time, clk, rst, numero2Bits, numero4Bits, numero6Bits);

    clk <= 0;
    rst <= 0;
    

    #5  rst <= 1;                   
    #5  rst <= 0;
	 
	 #30  rst <= 1;                   
    #5  rst <= 0;
	

    #190 assert(numero2Bits == 2'b10) else $error("Contador 2 bits falló");
	 assert(numero4Bits == 4'b0010) else $error("Contador 4 bits falló");
	 assert(numero6Bits == 6'b010010) else $error("Contador 6 bits falló");
	  

	  
	 #5 $finish;
	 
	 end
	 
	 initial begin
    $dumpvars;
    $dumpfile("test.vcd");
  end
endmodule
