--For spartan 3
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SS_Handler is
  port (
        clk           :in std_logic;
        --Reset         :in std_logic;
        --IN 
        SegmentLEDs_1 :in std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
        SegmentLEDs_2 :in std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
        SegmentLEDs_3 :in std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
        SegmentLEDs_4 :in std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
        
        --OUT
        SegmentLEDs   :out std_logic_vector (7 downto 0); --a,b,c,d,e,f,g,dp
      
        --Segment Selection Lines
        SegmentSel    :out std_logic_vector(3 downto 0);-- := "ZZZZ"
  );
end SS_Handler;


architecture behaviour of SS_Handler is


  signal counter: integer range 0 to 8000 := 0; 
  --signal SegmentSel: std_logic_vector(3 downto 0) := "ZZZZ";
  begin
process(clk)
  begin


    if rising_edge(clk) then 
		if counter < 8000 then 
			counter <= counter+1;
		else
			counter <= 0;	    
    end if;
    end if;
    
    --if reset = '1' then 
    --counter <= 0;
    --SegmentSel  <= "ZZZZ";
    --SegmentLEDs <=  SegmentLEDs_1;

    --elsif  counter < 2000 then 
    --counter <= counter + 1;
    if  counter < 2000 then
    SegmentSel  <= "ZZZ1";
    SegmentLEDs <=  SegmentLEDs_1;

    elsif (counter  < 4000)  then
    SegmentSel  <= "ZZ1Z";
    SegmentLEDs <=  SegmentLEDs_2;
    --counter <= counter + 1;

    elsif(counter  < 6000)  then
    SegmentSel  <= "Z1ZZ";
    SegmentLEDs <=  SegmentLEDs_3; 
    --counter <= counter + 1;

    elsif(counter  < 8000)  then
    SegmentSel  <= "1ZZZ";
    SegmentLEDs <= SegmentLEDs_4;
    --counter <= counter + 1;

    --elsif rising_edge(clk) and (counter = 8000) then
      --counter <= 0;
    else
    SegmentSel  <= "ZZZ1";
    SegmentLEDs <=  SegmentLEDs_1;
          
  end if;  



  end process; -- identifier

end behaviour;