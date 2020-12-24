library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity Register_output is
port(
	--Clock, Reset
		Clk 	: in std_logic;
    Reset	: in std_logic;
	--Inputs 
		Set_CU	: in std_logic;
		Data_in: in std_logic_vector(7 downto 0);
		
  --Outputs
	  Data_out:out integer range 0 to 225);
end entity;


architecture behavioral of Register_output is
signal temp_out : integer range 0 to 225 := 0;
begin 

process(Clk,Reset,Set_CU,Data_in)
begin
	if (reset = '1') then
		temp_out <= 0;
	elsif(rising_edge(Clk)) then 
		if (Set_CU ='1') then
			temp_out <= to_integer(unsigned (Data_in));
		end if;
	end if;
end process;


--Local assignments
Data_out <= temp_out;

end behavioral;
		    
	 