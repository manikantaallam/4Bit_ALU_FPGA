library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Current_Disp_State is
port(
  --Inputs
     Stage1_curr_o1		:in integer range 0 to 15;
     Stage2_curr_o2 	:in integer range 0 to 15;
     Stage3_curr_oPC 	:in integer range 0 to 7;
     ALU_out         	:in integer range 0 to 255;
  --Selection line
     Current_Display_Selector         	:in std_logic_vector(1 downto 0);

  --Output
     Current_Display_Output          	  :out integer range 0 to 255 
     );
end entity;


architecture arch of Current_Disp_State is
begin

  process(Stage1_curr_o1, Stage2_curr_o2, Stage3_curr_oPC, ALU_out, Current_Display_Selector)
  begin
    case Current_Display_Selector is 

        when  "00"   =>   Current_Display_Output  <= Stage1_curr_o1;
      
        when  "01"   =>   Current_Display_Output  <= Stage2_curr_o2;

        when  "10"   =>   Current_Display_Output  <= Stage3_curr_oPC;

        when  "11"   =>   Current_Display_Output  <= ALU_out;

        when others  =>    Current_Display_Output  <= Stage1_curr_o1;

    end case;

  end process; 

end arch;