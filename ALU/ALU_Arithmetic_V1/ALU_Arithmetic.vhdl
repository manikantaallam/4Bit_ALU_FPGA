library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


Entity ALU_Arithmetic is
port(
        clk     :in std_logic;
        Reset   :in std_logic;
        o1_in	:in  std_logic_vector(3 downto 0);
		o2_in	:in  std_logic_vector(3 downto 0);
		opc     :in std_logic_vector(2 downto 0);
		o_Add	:out std_logic_vector(7 downto 0);
		o_Sub	:out std_logic_vector(7 downto 0);
		o_Mult	:out std_logic_vector(7 downto 0));
end entity;

architecture behavioral of ALU_Arithmetic is
component adder is
port(
        A,B	    :in  std_logic_vector(3 downto 0);
	    Sum 	:out std_logic_vector(7 downto 0));
end component;

component subtractor is
port(A		:in std_logic_vector(3 downto 0);
     B		:in std_logic_vector(3 downto 0);
	 Sub	:out std_logic_vector(7 downto 0));
end component;

Component ALU_Mult is
  port (
    clk     :in std_logic;
    Reset   :in std_logic;
    A       :in std_logic_vector(3 downto 0);
    B       :in std_logic_vector(3 downto 0);
	sel     :in std_logic_vector(2 downto 0);
    Y_Mult  :out std_logic_vector(7 downto 0)) ;
end component ;


begin
sum:adder port map(o1_in,o2_in,o_Add);
Sub:subtractor port map(o1_in,o2_in,o_Sub);
Mult:ALU_Mult port map(clk,reset,o1_in,o2_in,opc,o_Mult);
end behavioral;



