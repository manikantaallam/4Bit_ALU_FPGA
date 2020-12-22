Library IEEE;
Use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use  ieee.std_logic_unsigned.all; --Mult123


entity ALU_Mult is
  port (
    clk     :in std_logic;
    Reset   :in std_logic;
    A       :in std_logic_vector(3 downto 0);
    B       :in std_logic_vector(3 downto 0) ;
    Y_Mult       :out std_logic_vector(7 downto 0);
    sel     :in std_logic_vector(2 downto 0)
  ) ;
end ALU_Mult ;

architecture behavioral of ALU_Mult is

    signal Y_s      :std_logic_vector(7 downto 0):=(others=>'0'); 
    signal A_S      :std_logic_vector(7 downto 0):=(others=>'0');  
    
    
begin

A_S <= "0000"& A;

Mult : process( clk,A,B,Reset )

variable counter :integer range 0 to 15 :=0;
variable Bint    :integer range 0 to 15;

variable A_Var   :std_logic_vector(7 downto 0):=(others=>'0');


begin
    Bint := to_integer(unsigned(B));   

if Reset = '1' then 
    counter   := 0;
    Bint      := 0;
    Y_s       <= (others=>'0');
    A_Var     := (others=>'0');

elsif sel = "111" then
        if counter = Bint then
            --counter := 0;
           Y_s <= A_var;
        elsif rising_edge(clk) and counter < Bint  then
          A_var := A_var + A_S;
          counter := counter+1;
        end if;  
end if;

Y_Mult <= Y_s;    
    
end process ; -- identifier



end behavioral; -- arch

