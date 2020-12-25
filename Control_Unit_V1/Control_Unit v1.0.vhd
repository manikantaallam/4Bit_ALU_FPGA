library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library synplify;
--use synplify.attributes.all;


entity Control_Unit is
  port (
   --Clock and Reset
      clk           :in std_logic;
      Reset         :in std_logic;

    --Input Signals  

    Inc       :in std_logic;
    Dec       :in std_logic;
    Set       :in std_logic;
    NextStage :in std_logic;
    
    --OUT
    --Stage1
    o1_in            : out integer range 0 to 15;
    Stage1_curr_o1   : out integer range 0 to 15;

    --Stage2
    o2_in            : out integer range 0 to 15;
    Stage2_curr_o2   : out integer range 0 to 15;

    --Stage3
    oPC_in           : out integer range 0 to 7;
    Stage3_curr_oPC  : out integer range 0 to 7;

    --Stage4
    Set_CU           : out std_logic;
    

    --Common for all stages
    Current_Display_Value_Selector  :out std_logic_vector(1 downto 0);
    Cur_D_St_E_Val                  :out integer range 0 to 3;
    Sel_SS_Assigner                 :out std_logic_vector(1 downto 0)
  );
  --attribute syn_preserve : boolean;
  --attribute syn_preserve of Sel_SS_Assigner : signal is true;
  --attribute syn_preserve : boolean;
  --attribute syn_preserve of Current_Display_Value_Selector : signal is true;

end Control_Unit;




architecture behaviour of Control_Unit is
 
  -- Enumerated type declaration and state signal declaration
   type t_State is (Stage1, Stage2, Stage3, Stage3_1, Stage4);
  
  --Signal Declaration  
  signal State : t_State;

--Local Signals
signal Stage1_curr_o1_S    :integer range 0 to 15 := 0;
signal Stage2_curr_o2_S    :integer range 0 to 15 := 0;
signal Stage3_curr_oPC_S   :integer range 0 to 7  := 0;

begin

process(clk,Reset,Inc,Dec, NextStage)
variable counter : integer range 0 to 25 := 0;
begin 

if Reset = '1' then    -- Active High Asynchronous Reset

  State <= Stage1;
  Current_Display_Value_Selector <= "00";
  Sel_SS_Assigner                <= "00";
  Cur_D_St_E_Val                 <= 0;

  Stage1_curr_o1_S               <= 0;
  Stage2_curr_o2_S               <= 0;
  Stage3_curr_oPC_S              <= 0;
  
  counter := 0; 

  Set_CU <= '0';
  


elsif rising_edge(clk) then

    case State is

when Stage1 =>        --For Operand1 Selection and Setting  
--For Display Drivers 
        Current_Display_Value_Selector <= "00";
        Sel_SS_Assigner                <= "00";
        Cur_D_St_E_Val                 <= 0;
        
--for Incrementing  &  Decrementing          
        if Inc = '1' and Stage1_curr_o1_S < 15 then            
         Stage1_curr_o1_S <=  Stage1_curr_o1_S + 1;
        elsif Inc = '1' and Stage1_curr_o1_S = 15 then 
        Stage1_curr_o1_S <= 0;
        end if;
        
        if Dec = '1' and Stage1_curr_o1_S = 0 then
          Stage1_curr_o1_S <= 15;
        elsif Dec = '1' and Stage1_curr_o1_S <= 15 then           
        Stage1_curr_o1_S <=  Stage1_curr_o1_S - 1;        
        end if;   

--Next State Logic
       if NextStage = '1' then
         state <= Stage2;
       else
         state <= Stage1;
       end if;



When Stage2 =>        --For Operand2 Selection and Setting
        Current_Display_Value_Selector <= "01";
        Sel_SS_Assigner                <= "01";
        Cur_D_St_E_Val                 <= 1;

--for Incrementing  &  Decrementing          
        if Inc = '1' and Stage2_curr_o2_S < 15 then            
        Stage2_curr_o2_S <=  Stage2_curr_o2_S + 1;
        elsif Inc = '1' and Stage2_curr_o2_S = 15 then 
        Stage2_curr_o2_S <= 0;
        end if;
        
        if Dec = '1' and Stage2_curr_o2_S = 0 then
          Stage2_curr_o2_S <= 15;
        elsif Dec = '1' and Stage2_curr_o2_S <= 15 then           
        Stage2_curr_o2_S <=  Stage2_curr_o2_S - 1;        
        end if;       
            
--Next State Logic
        if NextStage = '1' then
          state <= Stage3;
        else
          state <= Stage2;
        end if;


   
When Stage3 =>         --For Operator Selection and Setting 
        Current_Display_Value_Selector <= "10";
        Sel_SS_Assigner                <= "10";
        Cur_D_St_E_Val                 <= 2;

--for Incrementing  &  Decrementing          
        if Inc = '1' and Stage3_curr_oPC_S < 7 then            
        Stage3_curr_oPC_S <=  Stage3_curr_oPC_S + 1;
        elsif Inc = '1' and Stage3_curr_oPC_S = 7 then 
        Stage3_curr_oPC_S <= 0;
        end if;

        if Dec = '1' and Stage3_curr_oPC_S = 0 then
          Stage3_curr_oPC_S <= 7;
        elsif Dec = '1' and Stage3_curr_oPC_S <= 7 then           
        Stage3_curr_oPC_S <=  Stage3_curr_oPC_S - 1;        
        end if;    
   


--Next State Logic and wait for ALU to do Operations
       if NextStage = '1' then
         state <= Stage3_1;
      else
      state <= Stage3;
      end if;

when Stage3_1 =>
      if counter < 20 then 
      counter :=  counter + 1;
      state <= Stage3_1;
      elsif counter = 20 then
      state <= Stage4;
      counter := 0;
      end if;

When Stage4 =>           --For Output Displaying
       Current_Display_Value_Selector <= "11";
       Sel_SS_Assigner                <= "11";
       Cur_D_St_E_Val                 <= 3;
       Set_CU                         <= '1';                       
--Next State Logic
       if NextStage = '1' then
         state <= Stage1;
       else
         state <= Stage4;
       end if;


    
When others =>
       Current_Display_Value_Selector <= "00";
       Sel_SS_Assigner                <= "00";
       Cur_D_St_E_Val                 <= 0;
       state <= Stage1; 
end case;   
  
end if;

end process; -- identifier




--Signal Assignments
Stage1_curr_o1  <= Stage1_curr_o1_S;
Stage2_curr_o2  <= Stage2_curr_o2_S;
Stage3_curr_oPC <= Stage3_curr_oPC_S;

--Combinational Assignments
-- For registering operand1 to ALU
o1_in <= Stage1_curr_o1_S; --when   (Set =  '1' and State <= Stage1 )   else 0;
-- For registering operand2 to ALU
o2_in <= Stage2_curr_o2_S;  --when  (Set =  '1' and State <= Stage2 )   else 0;
-- For registering oP Code to ALU
oPC_in <= Stage3_curr_oPC_S; --when (Set =  '1' and State <= Stage3)    else 0;




end architecture; -- arch




