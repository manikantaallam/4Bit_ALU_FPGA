library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SS_Handler is
  port (
   --Clock and Reset
      clk           :in std_logic;
    --Reset         :in std_logic;

    --Segment Data Ports
    
    --IN 
    SegmentLEDs_1 :in std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
    SegmentLEDs_2 :in std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
    SegmentLEDs_3 :in std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
    SegmentLEDs_4 :in std_logic_vector(7 downto 0);   --dp,g,f,e,d,c,b,a
    
    --OUT
    SegmentLEDs   :out std_logic_vector (7 downto 0); --a,b,c,d,e,f,g,dp
  
    --Segment Selection Lines
    SegmentSel    :out std_logic_vector(3 downto 0)
  );
end SS_Handler;

architecture behaviour of SS_Handler is

   -- Enumerated type declaration and state signal declaration
   type t_State is (SS1, SS2, SS3, SS4);
  
  --Signal Declaration  
  signal State : t_State;


 --for test purpose
 -- signal SegmentLEDs_1: std_logic_vector(7 downto 0) := ("11111001"); --1   --dp,g,f,e,d,c,b,a
 -- signal SegmentLEDs_2: std_logic_vector(7 downto 0) := ("00100100"); --8.  --dp,g,f,e,d,c,b,a
 -- signal SegmentLEDs_3: std_logic_vector(7 downto 0) := ("11111000"); --1   --dp,g,f,e,d,c,b,a
 -- signal SegmentLEDs_4: std_logic_vector(7 downto 0) := ("11111000"); --9   --dp,g,f,e,d,c,b,a
begin
process(clk)

variable counter : integer range 0 to 240000 := 0;

begin
  
  if rising_edge(clk) then

    case State is

    when SS1 => 
    if rising_edge(clk) and counter < 60000 then 
    state <= SS1;
    counter := counter + 1;
    elsif counter = 60000 then
    state <= SS2; 
    end if;

    SegmentSel  <= "ZZZ1";
    SegmentLEDs <=  SegmentLEDs_1;
    

    When SS2 =>
    if rising_edge(clk) and counter < 120000 then 
    state <= SS2;
    counter := counter + 1;
    elsif counter = 120000 then
    state <= SS3; 
    end if;

    SegmentSel  <= "ZZ1Z";
    SegmentLEDs <=  SegmentLEDs_2;
    
    
    When SS3 =>
    if rising_edge(clk) and counter < 180000 then 
    state <= SS3;
    counter := counter + 1;
    elsif counter = 180000 then
      state <= SS4; 
    end if;

    SegmentSel  <= "Z1ZZ";
    SegmentLEDs <=  SegmentLEDs_3;
   

    When SS4 =>
    if rising_edge(clk) and counter < 240000 then 
    state <= SS4;
    counter := counter + 1;
    elsif counter = 240000 then
      state <= SS1; 
      counter := 0;
    end if;
    
    SegmentSel  <= "1ZZZ";
    SegmentLEDs <= SegmentLEDs_4;
    
    
    When others =>
    state <= SS1;
    counter := 0;
    end case;   
  
  end if;

end process; -- identifier

end architecture; -- arch