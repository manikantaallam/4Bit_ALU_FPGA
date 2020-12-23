library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SS_Assigner is
port(
  --Inputs
  Cur_D_Val_SS_out		  :in std_logic_vector(23 downto 0);
  Cur_D_E_Val_SS_out 	:in std_logic_vector(23 downto 0);    
     
  --Selection line
  Sel_SS_Assigner      :in std_logic_vector(1 downto 0);

  --Output
  SegmentLEDs_1 :out std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
  SegmentLEDs_2 :out std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
  SegmentLEDs_3 :out std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
  SegmentLEDs_4 :out std_logic_vector(7 downto 0)    --dp,g,f,e,d,c,b,a
     );
end entity;


architecture arch of SS_Assigner is
begin

  process(Cur_D_Val_SS_out,Cur_D_E_Val_SS_out,Sel_SS_Assigner)
  begin
    case Sel_SS_Assigner is 

        when  "00"   =>   
            SegmentLEDs_1 <= Cur_D_Val_SS_out(23 downto 16);
            SegmentLEDs_2 <= Cur_D_Val_SS_out(15 downto 8);
            SegmentLEDs_3 <= Cur_D_E_Val_SS_out(15 downto 8);
            SegmentLEDs_4 <= Cur_D_E_Val_SS_out(23 downto 16);

        when  "01"   =>   
            SegmentLEDs_1 <= Cur_D_Val_SS_out(23 downto 16);
            SegmentLEDs_2 <= Cur_D_Val_SS_out(15 downto 8);
            SegmentLEDs_3 <= Cur_D_E_Val_SS_out(15 downto 8);
            SegmentLEDs_4 <= Cur_D_E_Val_SS_out(23 downto 16);

        when  "10"   =>   
            SegmentLEDs_1 <= Cur_D_Val_SS_out(23 downto 16);
            SegmentLEDs_2 <= Cur_D_E_Val_SS_out(7 downto 0);
            SegmentLEDs_3 <= Cur_D_E_Val_SS_out(15 downto 8);
            SegmentLEDs_4 <= Cur_D_E_Val_SS_out(23 downto 16);

        when  "11"   =>
            SegmentLEDs_1 <= Cur_D_Val_SS_out(23 downto 16);
            SegmentLEDs_2 <= Cur_D_Val_SS_out(15 downto 8);
            SegmentLEDs_3 <= Cur_D_Val_SS_out(7 downto 0);
            SegmentLEDs_4 <= Cur_D_E_Val_SS_out(23 downto 16);   

        when others  => 
            SegmentLEDs_1 <= Cur_D_Val_SS_out(23 downto 16);
            SegmentLEDs_2 <= Cur_D_Val_SS_out(15 downto 8);
            SegmentLEDs_3 <= Cur_D_E_Val_SS_out(15 downto 8);
            SegmentLEDs_4 <= Cur_D_E_Val_SS_out(23 downto 16);   

    end case;

  end process; 

end arch;