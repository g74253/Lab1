
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY Sumador_4bits_TB IS
END Sumador_4bits_TB;
 
ARCHITECTURE behavior OF Sumador_4bits_TB IS 
 
    COMPONENT Sumador_4bits
    PORT(
         iA : IN  std_logic_vector(3 downto 0);
         iB : IN  std_logic_vector(3 downto 0);
         iCin : IN  std_logic;
         Cout : OUT  std_logic;
			oSum : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal iA : std_logic_vector(3 downto 0) := (others => '0');
   signal iB : std_logic_vector(3 downto 0) := (others => '0');
   signal iCin : std_logic := '0';

 	--Outputs
   signal Cout : std_logic;
   signal oSum : std_logic_vector(3 downto 0);
 
 
 
BEGIN
 
	--Unit Under Test (UUT)
   uut: Sumador_4bits PORT MAP (
          iA => iA,
          iB => iB,
          iCin => iCin,
          Cout => Cout,
			 oSum => oSum );


   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;	

		iA<="0010";
		iB<="0011";
		
      wait for 10 ns;
		
		iA<="1010";
		iB<="0001";
		
     wait for 10 ns;	
	  
	   iA<="1111";
		iB<="1111";
	  
     wait for 10 ns;	
		iA<="1110";
		iB<="0101";

      wait;
   end process;

END;

