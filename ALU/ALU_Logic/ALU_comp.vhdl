library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


Entity ALU_Comp is
port(
        A,B	    :in  std_logic_vector(3 downto 0);
        Y_comp	:out std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of ALU_comp is
begin

y_comp <= "0000"&(A XNOR B);

end behavioral;

