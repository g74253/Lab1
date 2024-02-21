
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY Sumador_4bits_TB IS
END Sumador_4bits_TB;
 
ARCHITECTURE behavior OF Sumador_4bits_TB IS 
 
    COMPONENT Sumador_4bit
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         Cin : IN  std_logic;
			Sum : OUT  std_logic_vector(3 downto 0);
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal Cin : std_logic := '0';

 	--Outputs
   signal Cout : std_logic;
   signal Sum : std_logic_vector(3 downto 0);
 
 
 
BEGIN
 
	--Unit Under Test (UUT)
   uut: Sumador_4bit PORT MAP (
          A => A,
          B => B,
          Cin => Cin,
			 Sum => Sum,
          Cout => Cout
        );


   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;	

		A<="0010";
		B<="0011";
		
      wait for 10 ns;
		
		A<="1010";
		B<="0001";
		
     wait for 10 ns;	
	  
	   A<="1010";
		B<="0001";
	  
     wait for 10 ns;	
		A<="1110";
		B<="0101";

      wait;
   end process;

END;

