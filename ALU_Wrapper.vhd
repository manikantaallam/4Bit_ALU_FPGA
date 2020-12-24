library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ALU_Wrapper is
  port (
--Clock and Reset
  clk     :in std_logic;
  Reset   :in std_logic;

--Input Ports
  SW1     :in std_logic;
  SW2     :in std_logic;
  SW3     :in std_logic;
  SW4     :in std_logic;

--Output Ports
SegmentLEDs   :out std_logic_vector (7 downto 0); --a,b,c,d,e,f,g,dp
SegmentSel    :out std_logic_vector(3 downto 0) );

end ALU_Wrapper;


architecture Structural of ALU_Wrapper is

--Components  
--Debounce
component DeBounce is
  port(       Clock   : in std_logic;
              Reset   : in std_logic;
         button_in    : in std_logic;
         pulse_out    : out std_logic
      );
end component;

--Control Unit
Component Control_Unit is
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
end Component;



--Registers
----Register Component
Component Register_Component is
  port(
    --Clock, Reset
      Clk 	: in std_logic;
      Reset	: in std_logic;
    --Inputs 
      Set	: in std_logic;
      Data_in: in integer range 0 to 15;
      
    --Outputs
      Data_out:out std_logic_vector(3 downto 0));
  end Component;

----Register oPC
Component Register_oPC is
  port(
    --Clock, Reset
      Clk 	: in std_logic;
         Reset	: in std_logic;
    --Inputs 
      Set	    : in std_logic;
      Data_in: in integer range 0 to 7;
      
    --Outputs
      Data_out:out std_logic_vector(2 downto 0));
  end Component;

----Register Output
Component Register_output is
  port(
    --Clock, Reset
      Clk 	: in std_logic;
      Reset	: in std_logic;
    --Inputs 
      Set_CU	: in std_logic;
      Data_in: in std_logic_vector(7 downto 0);
      
    --Outputs
      Data_out:out integer range 0 to 225);
  end Component;



--ALU
Component ALU is
  port(
          clk     :in std_logic;
          Reset   :in std_logic;
          o1_in    :in  std_logic_vector(3 downto 0);
          o2_in   :in  std_logic_vector(3 downto 0);
          oPC     :in std_logic_vector(2 downto 0);
          ALU_Out :out std_logic_vector(7 downto 0));
  end Component;

--Current Display State
Component Current_Disp_State is
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
  end Component;

--ROMs
----Decimal Equ. ROM
Component ROM_Decimal_Equivalents is
  port (
        --clk     :in std_logic;
       -- reset   :in std_logic;

        --Address for ROM Data
        Cur_D_Val_Out :in integer range 0 to 255;
        

        --Output for Seven Segments // Shall portmap accordingly to the SSHandler component
        Cur_D_Val_SS_out :out std_logic_vector(23 downto 0)  --dp,g,f,e,d,c,b,a --dp,g,f,e,d,c,b,a --dp,g,f,e,d,c,b,a
         
  );
end Component;

----English Equivalent ROM
Component ROM_English_Equivalents is
  port (
        --clk     :in std_logic;
       -- reset   :in std_logic;

        --Address for ROM Data
        Cur_D_St_E_Val :in integer range 0 to 3;
        

        --Output for Seven Segments // Shall port map accordingly to the SSHandler component
        Cur_D_E_V_SS_out :out std_logic_vector(23 downto 0)  --dp,g,f,e,d,c,b,a --dp,g,f,e,d,c,b,a --dp,g,f,e,d,c,b,a        
         
  );
end Component;


--SS Display Assigner
Component SS_Assigner is
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
  end Component;

--SSHandler
Component SS_Handler is
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
end Component;  



--Local Signals for Control Unit
signal S_Inc       :std_logic;
signal S_Dec       :std_logic;
signal S_Set       :std_logic;
signal S_NextStage :std_logic;
signal S_o1_in                            : integer range 0 to 15;
signal S_Stage1_curr_o1                   : integer range 0 to 15;    
signal S_o2_in                            : integer range 0 to 15;
signal S_Stage2_curr_o2                   : integer range 0 to 15;   
signal S_oPC_in                           : integer range 0 to 7;
signal S_Stage3_curr_oPC                  : integer range 0 to 7;   
signal S_Set_CU                           : std_logic; 
signal S_Current_Display_Value_Selector   : std_logic_vector(1 downto 0);
signal S_Cur_D_St_E_Val                   : integer range 0 to 3;
signal S_Sel_SS_Assigner                  : std_logic_vector(1 downto 0);

--Local Signals for ALU
signal S_ALU_o1_in   : std_logic_vector(3 downto 0);
signal S_ALU_o2_in   : std_logic_vector(3 downto 0);
signal S_ALU_oPC     : std_logic_vector(2 downto 0);
signal S_ALU_ALU_Out : std_logic_vector(7 downto 0);


--Local Signals for Current_Disp_State
signal S_CDS_Stage1_curr_o1		                  :integer range 0 to 15;
signal S_CDS_Stage2_curr_o2 	                  :integer range 0 to 15;
signal S_CDS_Stage3_curr_oPC 	                  :integer range 0 to 7;
signal S_CDS_ALU_out         	                  :integer range 0 to 255;
signal S_CDS_Current_Display_Selector         	:std_logic_vector(1 downto 0);
signal S_CDS_Current_Display_Output          	  :integer range 0 to 255;

--Local Signals for ROM decimal Equivalent
signal S_RDE_Cur_D_Val_Out    :integer range 0 to 255;  
signal S_RDE_Cur_D_Val_SS_out :std_logic_vector(23 downto 0); 

--Local Signals for ROM English Equivalent
signal S_REE_Cur_D_St_E_Val   :integer range 0 to 3; 
signal S_REE_Cur_D_E_V_SS_out :std_logic_vector(23 downto 0);  

--Local Signals for SS Assigner
signal S_SSA_SegmentLEDs_1        : std_logic_vector(7 downto 0);   
signal S_SSA_SegmentLEDs_2        : std_logic_vector(7 downto 0);   
signal S_SSA_SegmentLEDs_3        : std_logic_vector(7 downto 0);   
signal S_SSA_SegmentLEDs_4        : std_logic_vector(7 downto 0);    



begin

--Instantiations

--Debounce
Switch1:DeBounce port map (clk, Reset, SW1, S_Inc);
Switch2:DeBounce port map (clk, Reset, SW2, S_Dec);
Switch3:Debounce port map (clk, Reset, Sw3, S_Set);
Switch4:Debounce port map (clk, Reset, Sw4, S_NextStage);

--Control Unit
ControlUnit:Control_Unit port map(clk, Reset, S_Inc, S_Dec, S_Set, S_NextStage, S_o1_in, S_Stage1_curr_o1, S_o2_in, S_Stage2_curr_o2, S_oPC_in, S_Stage3_curr_oPC, S_Set_CU, S_Current_Display_Value_Selector, S_Cur_D_St_E_Val, S_Sel_SS_Assigner);

--Registers
Registero1  :Register_Component port map(Clk, Reset, SW3, S_o1_in, S_ALU_o1_in);
Registero2  :Register_Component port map(Clk, Reset, SW3, S_o2_in, S_ALU_o2_in);
RegisteroPC :Register_oPC       port map(Clk, Reset, SW3, S_oPC_in, S_ALU_oPC);
Registerout :Register_output    port map(clk, Reset, S_Set_CU, S_ALU_ALU_Out,S_CDS_ALU_out);

--ALU
ALUv1:ALU port map(clk,Reset,S_ALU_o1_in,S_ALU_o2_in,S_ALU_oPC,S_ALU_ALU_Out);


--Current Display State | Display Driver
CDState:Current_Disp_State port map(S_CDS_Stage1_curr_o1,S_CDS_Stage2_curr_o2,S_CDS_Stage3_curr_oPC,S_CDS_ALU_out,S_CDS_Current_Display_Selector,S_CDS_Current_Display_Output);

--ROM Decimal Equivalent
ROM_D_E:ROM_Decimal_Equivalents port map(S_RDE_Cur_D_Val_Out,S_RDE_Cur_D_Val_SS_out);
ROM_E_E:ROM_English_Equivalents port map(S_REE_Cur_D_St_E_Val,S_REE_Cur_D_E_V_SS_out);

--SS Assigner
SSA:SS_Assigner port map(S_RDE_Cur_D_Val_SS_out, S_REE_Cur_D_E_V_SS_out, S_Sel_SS_Assigner, S_SSA_SegmentLEDs_1, S_SSA_SegmentLEDs_2, S_SSA_SegmentLEDs_3, S_SSA_SegmentLEDs_4);

--SS Handler
SSH:SS_Handler port map(clk,S_SSA_SegmentLEDs_1,S_SSA_SegmentLEDs_2, S_SSA_SegmentLEDs_3, S_SSA_SegmentLEDs_4,SegmentLEDs,SegmentSel);

end Structural;