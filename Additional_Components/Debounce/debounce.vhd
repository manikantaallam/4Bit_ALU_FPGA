library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DeBounce is
    port(       Clock   : in std_logic;
                Reset   : in std_logic;
           button_in    : in std_logic;
           pulse_out    : out std_logic
        );
end DeBounce;

architecture behav of DeBounce is

--the below constants decide the working parameters.

--constant COUNT_MAX1 : integer := 400000; --Bounce cycle counts || 20MHz 50ns cycle period   || 20ms Rejection time For Spartan3
--constant COUNT_MAX2 : integer := 800000; -- -- Wait after output assertion For Spartan3


constant COUNT_MAX1 : integer   := 240096; --Bounce time counting  || 12MHz 83.3ns cycle period || 20ms Rejection time For lattice ice40-hx8k breakout board
constant COUNT_MAX2 : integer   := 4440096; -- Wait after output assertion || For lattice ice40-hx8k breakout board

constant BTN_ACTIVE : std_logic := '1'; -- Active high assertion of of the button

signal count : integer := 0;
signal count2 : integer := 0;
type state_type is (idle,wait_time,OP,OP_wait); --state Signals
signal state : state_type := idle;

begin
  
process(Reset,Clock)

begin
    if(Reset = '1') then
        state <= idle;
        pulse_out <= '0';
   elsif(falling_edge(Clock)) then
        case (state) is

--wait until button is pressed
            when idle =>
                if(button_in = BTN_ACTIVE) then  
                    state <= wait_time;
                else
                    state <= idle; 
                end if;

                pulse_out <= '0';

--Wait till the bounce time is fulfilled
            when wait_time => 
            if(count = COUNT_MAX1) then
                count <= 0;
                    if(button_in = BTN_ACTIVE) then
                    state <= OP;
                    end if;                 
            else
                count <= count + 1;
            end if; 
--Assert pulse
            when OP => 
              pulse_out <= '1';
              count2<=0;                
              state <= OP_wait;
              
--Wait for button to release after assertion
            when OP_wait =>
            pulse_out <= '0';
              if count2 = COUNT_MAX2 then               
              state <= idle; 
              elsif count2 <= COUNT_MAX2 then            
              count2 <= count2 + 1;               
              end if;  


        end case;       
    end if;        
end process;                  
                                                                                
end architecture behav;