library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


Entity ALU_Logic is
port(
        clk     :in std_logic;
        Reset   :in std_logic;
        o1_in    :in  std_logic_vector(3 downto 0);
        o2_in   :in  std_logic_vector(3 downto 0);
		opc     :in std_logic_vector(2 downto 0);
	    o_Comp	:out std_logic_vector(7 downto 0);
		o_OR	:out std_logic_vector(7 downto 0);
		o_SR	:out std_logic_vector(7 downto 0));
end entity;

architecture behavioral of ALU_Logic is


component ALU_comp is 
port(
        A,B	    :in  std_logic_vector(3 downto 0);
        Y_comp	:out std_logic_vector(7 downto 0));
end component;

component ALU_OR is
port(A,B	    :in  std_logic_vector(3 downto 0);
     Y_OR		:out std_logic_vector(7 downto 0));
end component;

component Shift_Rotate is

port(	
		clk     :in std_logic;
   		Reset   :in std_logic;
		A,B		:in  std_logic_vector(3 downto 0);
     	Sel		:in  std_logic_vector(2 downto 0);
	 	Y_SR	:out std_logic_vector(7 downto 0));
end component;

begin
comp		:ALU_comp port map(o1_in,o2_in,o_Comp);
Bitwise_or  :ALU_OR port map(o1_in,o2_in,o_OR);
SR			:Shift_Rotate port map(clk,reset,o1_in,o2_in,opc,o_SR);

end behavioral;




