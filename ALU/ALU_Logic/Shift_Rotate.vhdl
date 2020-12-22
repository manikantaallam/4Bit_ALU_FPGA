
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_UNSIGNED.ALL;

Entity Shift_Rotate is

port(	
		clk     :in std_logic;
   		Reset   :in std_logic;
		A,B		:in  std_logic_vector(3 downto 0);
     	Sel		:in  std_logic_vector(2 downto 0);
	 	Y_SR	:out std_logic_vector(7 downto 0)
		);
	 
end entity;


architecture behavioral of Shift_Rotate is
--Signal temp	 :std_logic_vector(3 downto 0):="0000";
signal B_int 	:integer range 0 to 15 :=0;
signal Y_s   	:unsigned(7 downto 0):=(others=>'0');
signal tempA	:unsigned (7 downto 0):= (others=>'0');
signal X		:std_logic_vector(7 downto 0):= (others=>'0');

begin

--X		<="0000"&A;
--tempA	<=unsigned(X);

B_int	<=to_integer(unsigned(B));

process(clk,sel,reset)
begin 

if reset = '1' then
	
	Y_s				<= (others=>'0');
	tempA			<= (others=>'0');
	X				<= (others=>'0');
elsif rising_edge(clk) then
X		<="0000"&A;
tempA	<=unsigned(X);
--B_int	<=to_integer(unsigned(B));
				
					if sel = "011" then 								--Shift left
						y_s<=shift_left(tempA,B_int);
					elsif sel ="100" then								--Rotate right 
						Y_s <= tempA ror B_int;
				
					end if;  
			
end if;				

end process;

Y_SR<=std_logic_vector(y_s);

end architecture;