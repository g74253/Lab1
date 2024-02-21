library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sumador_4bits is
    Port ( iA : in STD_LOGIC_VECTOR(3 downto 0);
           iB : in STD_LOGIC_VECTOR(3 downto 0);
           iCin : in STD_LOGIC;
           Cout : out STD_LOGIC;
			  oSum : out STD_LOGIC_VECTOR(3 downto 0));
end Sumador_4bits;

architecture Behavioral of Sumador_4bits is

	signal Carry : std_logic_vector(2 downto 0):= "000";

	component Sumador_1bit is
	Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
			  Sum : out STD_LOGIC);
	end component;


begin

    Sumador0: Sumador_1bit port map (A => iA(0), B => iB(0), Cin => '0', Cout => Carry(0), Sum => oSum(0));
    Sumador1: Sumador_1bit port map (A => iA(1), B => iB(1), Cin => Carry(0), Cout => Carry(1), Sum => oSum(1));
    Sumador2: Sumador_1bit port map (A => iA(2), B => iB(2), Cin => Carry(1), Cout => Carry(2), Sum => oSum(2));
    Sumador3: Sumador_1bit port map (A => iA(3), B => iB(3), Cin => Carry(2), Cout => Cout , Sum => oSum(3));

end Behavioral;