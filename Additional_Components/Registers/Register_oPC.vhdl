library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity Register_oPC is
port(
	--Clock, Reset
		Clk 	: in std_logic;
       Reset	: in std_logic;
	--Inputs 
		Set	    : in std_logic;
		Data_in: in integer range 0 to 7;
		
  --Outputs
	  Data_out:out std_logic_vector(2 downto 0));
end entity;


architecture behavioral of Register_oPC is
signal temp_data : std_logic_vector(2 downto 0) := (others=>'0');
begin 

process(Clk,Reset,Set,Data_in)
begin
	if (reset = '1') then
		temp_data <= "000";
	elsif (Set ='1') then	
			if(rising_edge(Clk)) then 		
			temp_data <= std_logic_vector(to_unsigned (Data_in,Data_out'length));
			end if;
	end if;
end process;


--Local assignments
Data_out <= temp_data;

end behavioral;
		    
	 