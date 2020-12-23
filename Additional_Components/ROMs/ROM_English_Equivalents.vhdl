library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;


entity ROM_English_Equivalents is
  port (
        --clk     :in std_logic;
       -- reset   :in std_logic;

        --Address for ROM Data
        Cur_D_St_E_Val :in integer range 0 to 3;
        

        --Output for Seven Segments // Shall port map accordingly to the SSHandler component
        Cur_D_E_V_SS_out :out std_logic_vector(23 downto 0)  --dp,g,f,e,d,c,b,a --dp,g,f,e,d,c,b,a --dp,g,f,e,d,c,b,a        
         
  );
end ROM_English_Equivalents;

architecture struct of ROM_English_Equivalents is  


  type ROM is Array (0 to 3) of std_logic_vector(23 downto 0);  
  signal ROM_Data :ROM := (
      
    "1111100110100011ZZZZZZZZ" ,   --o1   (--1oZ)
    "1010010010100011ZZZZZZZZ" ,   --o2   (--2oZ)
    "110001101000110010100011" ,   --oPC  (--CPo)
    "00100011ZZZZZZZZZZZZZZZZ"     --o.   (--o.ZZ)    

  );

begin

  Cur_D_E_V_SS_out <= ROM_Data (Cur_D_St_E_Val);

end struct;