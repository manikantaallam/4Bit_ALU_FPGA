library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


Entity ALU_OR is
port(
        A,B	    :in  std_logic_vector(3 downto 0);
        Y_OR	:out std_logic_vector(7 downto 0));
		
end entity;

architecture behavioral of ALU_OR is
begin

y_OR <= "0000"&(A OR B);

end behavioral;

