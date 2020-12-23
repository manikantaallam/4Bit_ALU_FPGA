Library IEEE;
Use IEEE.std_logic_1164.all;
entity out_Driver is
  port (
		o_Comp	:in   std_logic_vector(7 downto 0);
		o_OR	:in   std_logic_vector(7 downto 0);
      	o_SR	:in   std_logic_vector(7 downto 0);
        o_Add   :in   std_logic_vector(7 downto 0);
		o_Sub   :in   std_logic_vector(7 downto 0);
		o_Mult  :in   std_logic_vector(7 downto 0);
		opc  :in std_logic_vector(2 downto 0);
        ALU_Out :out  std_logic_vector(7 downto 0));
end out_Driver;

architecture arch of out_Driver is

begin
process(o_Comp,o_OR,o_SR,o_Add,o_Sub,o_Mult,opc)
  begin
   case opc is
    when "000" => 
     ALU_Out    <= "00000000";
    when "001" =>
      ALU_Out   <= o_Comp;
    when "010" => 
      ALU_Out   <= o_OR;
    when "011"  =>
      ALU_Out   <= o_SR;
	when "100"  =>
      ALU_Out   <= o_SR;
	when "101" => 
       ALU_Out  <= o_Add;
    when "110" => 
       ALU_Out  <= o_Sub;
    when "111" =>  
       ALU_Out  <= o_Mult;
    when others =>
       ALU_Out  <= (others =>'0'); 
 end case;
end process; -- identifier
end arch;