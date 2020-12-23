-------------------------4 bit full adder
library IEEE;
use IEEE.std_logic_1164.all;


entity adder is
port(A		:in std_logic_vector(3 downto 0);
     B		:in std_logic_vector(3 downto 0);
     Sum		:out std_logic_vector(7 downto 0));
	
end entity;

architecture behavioral of adder is

signal Carry		:std_logic_vector(6 downto 0) := (OTHERS =>'0');
signal C_out_temp 	:std_logic_vector(7 downto 0) := (OTHERS =>'0');
signal C_IN_TEMP    :std_logic := '0';

component fulladder is
port(A		:in std_logic;
     B		:in std_logic;
	   Cin	:in std_logic;
	   Sum	:out std_logic;
	   Cout	:out std_logic);
end component fulladder;	 
begin
FA0:fulladder port map(A(0),B(0),C_IN_TEMP,C_out_temp(0),Carry(0));
FA1:fulladder port map(A(1),B(1),Carry(0),C_out_temp(1),Carry(1));
FA2:fulladder port map(A(2),B(2),Carry(1),C_out_temp(2),Carry(2));
FA3:fulladder port map(A(3),B(3),Carry(2),C_out_temp(3),C_out_temp(4));

Sum <= C_out_temp;

end behavioral;


---Single bit full adder---------
library IEEE;
use IEEE.std_logic_1164.all;

Entity fulladder is
port(A	:in std_logic;
     B	:in std_logic;
	   Cin:in std_logic;
	   Sum	:out std_logic;
	   Cout:out std_logic);
end entity;

architecture behavioral of fulladder is
begin

Sum		<=A xor B xor Cin;
Cout	<=(A and B) or (Cin and A) or (Cin and B);

end behavioral;


