---------------------4 bit Full Subtractor------------------
library IEEE;
use Ieee.std_logic_1164.all;


entity subtractor is
port(A		:in std_logic_vector(3 downto 0);
     B		:in std_logic_vector(3 downto 0);
	   Sub	:out std_logic_vector(7 downto 0));
	
end entity;

architecture behavioral of subtractor is
signal Carry		:std_logic_vector(6 downto 0) := (OTHERS =>'0');
signal C_out_temp 	:std_logic_vector(7 downto 0) := (OTHERS =>'0');
signal C_IN_TEMP    :std_logic := '1';
signal tempB    :std_logic_vector (3 downto 0);

component fulladder_s is
port(A		:in std_logic;
     B		:in std_logic;
	   Cin	:in std_logic;
	   S		:out std_logic;
	   Cout	:out std_logic);
end component fulladder_s;

begin
tempB(0) <= not B(0);
tempB(1) <= not B(1);
tempB(2) <= not B(2);
tempB(3) <= not B(3);


FS0:fulladder_s port map(A(0),tempB(0),C_IN_TEMP,C_out_temp(0),Carry(0));
FS1:fulladder_s port map(A(1),tempB(1),Carry(0),C_out_temp(1),Carry(1));
FS2:fulladder_s port map(A(2),tempB(2),Carry(1),C_out_temp(2),Carry(2));
FS3:fulladder_s port map(A(3),tempB(3),Carry(2),C_out_temp(3),C_out_temp(4));

Sub <= C_out_temp;

end behavioral;



---Single bit full adder---------
library IEEE;
use IEEE.std_logic_1164.all;

Entity fulladder_s is
port(A	:in std_logic;
     B	:in std_logic;
	   Cin:in std_logic;
	   S	:out std_logic;
	   Cout:out std_logic);
end entity;

architecture behavioral of fulladder_s is
begin

S		<=A xor B xor Cin;
Cout	<=(A and B) or (Cin and A) or (Cin and B);

end behavioral;


