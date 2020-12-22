library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


Entity ALU is
port(
        clk     :in std_logic;
        Reset   :in std_logic;
        o1_in    :in  std_logic_vector(3 downto 0);
        o2_in   :in  std_logic_vector(3 downto 0);
				oPC     :in std_logic_vector(2 downto 0);
				ALU_Out :out std_logic_vector(7 downto 0));
end entity;

architecture struct of ALU is

Component ALU_Logic is
port(
        clk     :in std_logic;
        Reset   :in std_logic;
        o1_in    :in  std_logic_vector(3 downto 0);
        o2_in   :in  std_logic_vector(3 downto 0);
				opc     :in std_logic_vector(2 downto 0);
	    	o_Comp	:out std_logic_vector(7 downto 0);
				o_OR	:out std_logic_vector(7 downto 0);
				o_SR	:out std_logic_vector(7 downto 0));
end Component;

component ALU_Arithmetic is
port(
        clk     :in std_logic;
        Reset   :in std_logic;
        o1_in	:in  std_logic_vector(3 downto 0);
				o2_in	:in  std_logic_vector(3 downto 0);
				opc     :in std_logic_vector(2 downto 0);
				o_Add	:out std_logic_vector(7 downto 0);
				o_Sub	:out std_logic_vector(7 downto 0);
				o_Mult	:out std_logic_vector(7 downto 0));
end component;

component out_Driver is
  port (
				o_Comp	:in   std_logic_vector(7 downto 0);
				o_OR	:in   std_logic_vector(7 downto 0);
      	o_SR	:in   std_logic_vector(7 downto 0);
        o_Add   :in   std_logic_vector(7 downto 0);
				o_Sub   :in   std_logic_vector(7 downto 0);
				o_Mult  :in   std_logic_vector(7 downto 0);
				opc  :in std_logic_vector(2 downto 0);
        ALU_Out :out  std_logic_vector(7 downto 0));
end component;
---internal signals------

signal      o_Comp_s	: std_logic_vector(7 downto 0);
signal			o_OR_s	: std_logic_vector(7 downto 0);
signal			o_SR_s	: std_logic_vector(7 downto 0);
signal	    o_Add_s	: std_logic_vector(7 downto 0);
signal			o_Sub_s	: std_logic_vector(7 downto 0);
signal			o_Mult_s	: std_logic_vector(7 downto 0);

begin

Logic 			:ALU_Logic port map(clk,reset,o1_in,o2_in,opc,o_Comp_s,o_OR_s,o_SR_s);
Arithmetic	:ALU_Arithmetic port map(clk,reset,o1_in,o2_in,opc,o_Add_s,o_Sub_s,o_Mult_s);
ALUOutput		:out_Driver port map(o_Comp_s,o_OR_s,o_SR_s,o_Add_s,o_Sub_s,o_Mult_s,opc,ALU_Out);

end struct;






