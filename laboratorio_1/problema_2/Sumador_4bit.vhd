----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:22:17 09/16/2015 
-- Design Name: 
-- Module Name:    Sumador_4bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sumador_4bit is
    Port ( iAv : in  STD_LOGIC_VECTOR (3 downto 0);
           iBv : in  STD_LOGIC_VECTOR (3 downto 0);
           iCin : in  STD_LOGIC;
           oCarry : out  STD_LOGIC;
           ovSuma_4bit : out  STD_LOGIC_VECTOR (3 downto 0));
end Sumador_4bit;

architecture Behavioral of Sumador_4bit is

	
   signal svCarry: std_logic_vector(2 downto 0):= "000";
					
	COMPONENT Sumador_completo_1bit
	PORT(
		iA : IN std_logic;
		iB : IN std_logic;
		iCarry : IN std_logic;          
		oCarry : OUT std_logic;
		oSuma_1bit : OUT std_logic
		);
	END COMPONENT;
	
begin
	Inst_Sumador_completo_1bit_1: Sumador_completo_1bit PORT MAP(
		iA => iAv(0),
		iB => iBv(0),
		iCarry => '0' ,
		oCarry => svCarry(0),
		oSuma_1bit => ovSuma_4bit(0) 
	);
	
		Inst_Sumador_completo_1bit_2: Sumador_completo_1bit PORT MAP(
		iA => iAv(1),
		iB => iBv(1),
		iCarry => svCarry(0),
		oCarry => svCarry(1),
		oSuma_1bit => ovSuma_4bit(1)
	);
	
		Inst_Sumador_completo_1bit_3: Sumador_completo_1bit PORT MAP(
		iA => iAv(2),
		iB => iBv(2),
		iCarry => svCarry(1),
		oCarry => svCarry(2),
		oSuma_1bit => ovSuma_4bit(2)
	);
	
		Inst_Sumador_completo_1bit_4: Sumador_completo_1bit PORT MAP(
		iA => iAv(3),
		iB => iBv(3),
		iCarry => svCarry(2),
		oCarry => oCarry ,
		oSuma_1bit => ovSuma_4bit(3)
	);
	

end Behavioral;

