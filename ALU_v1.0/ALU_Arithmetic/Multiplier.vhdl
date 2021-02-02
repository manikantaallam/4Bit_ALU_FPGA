Library IEEE;
Use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use  ieee.std_logic_unsigned.all;


entity ALU_Mult is
  port (
    clk     :in std_logic;
    Reset   :in std_logic;
    A       :in std_logic_vector(3 downto 0);
    B       :in std_logic_vector(3 downto 0) ;
	sel     :in std_logic_vector(2 downto 0);	
    Y_Mult   :out std_logic_vector(7 downto 0)
   ) ;
end ALU_Mult ;

architecture behavioral of ALU_Mult is
begin

process(A,B,sel,clk,reset)
variable tempA,tempB :std_logic_vector(7 downto 0);
begin
	tempA := "00000000";
	tempB := "0000" & B;
	for i in 0 to 3 loop
		if A(i) = '1' then 
			tempA := tempA + tempB;
		end if;
		    tempB := tempB(6 downto 0) & '0';
		end loop;		
	 
			if rising_edge(clk) then
			  if sel = "111" and reset = '0' then 		
				Y_Mult <= tempA;
			  else
			    Y_Mult <= (others=>'0');
			  end if;
			end if;
end process;
end behavioral;



