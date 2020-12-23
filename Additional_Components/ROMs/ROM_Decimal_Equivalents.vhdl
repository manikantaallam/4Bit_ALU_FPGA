library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;


entity ROM_Decimal_Equivalents is
  port (
        --clk     :in std_logic;
       -- reset   :in std_logic;

        --Address for ROM Data
        Cur_D_Val_Out :in integer range 0 to 255;
        

        --Output for Seven Segments // Shall portmap accordingly to the SSHandler component
        Cur_D_Val_SS_out :out std_logic_vector(23 downto 0)  --dp,g,f,e,d,c,b,a --dp,g,f,e,d,c,b,a --dp,g,f,e,d,c,b,a
         
  );
end ROM_Decimal_Equivalents;

architecture struct of ROM_Decimal_Equivalents is  


  type ROM is Array (0 to 255) of std_logic_vector(23 downto 0);  
  signal ROM_Data :ROM := (
      
 "11000000ZZZZZZZZZZZZZZZZ" ,   --0 
 "11111001ZZZZZZZZZZZZZZZZ" ,   --1 
 "10100100ZZZZZZZZZZZZZZZZ" ,   --2 
 "10110000ZZZZZZZZZZZZZZZZ" ,   --3 
 "10011001ZZZZZZZZZZZZZZZZ" ,   --4 
 "10010010ZZZZZZZZZZZZZZZZ" ,   --5 
 "10000010ZZZZZZZZZZZZZZZZ" ,   --6 
 "11111000ZZZZZZZZZZZZZZZZ" ,   --7 
 "10000000ZZZZZZZZZZZZZZZZ" ,   --8 
 "10010000ZZZZZZZZZZZZZZZZ" ,   --9 
 "1100000011111001ZZZZZZZZ" ,   --10 
 "1111100111111001ZZZZZZZZ" ,   --11 
 "1010010011111001ZZZZZZZZ" ,   --12 
 "1011000011111001ZZZZZZZZ" ,   --13 
 "1001100111111001ZZZZZZZZ" ,   --14 
 "1001001011111001ZZZZZZZZ" ,   --15 
 "1000001011111001ZZZZZZZZ" ,   --16 
 "1111100011111001ZZZZZZZZ" ,   --17 
 "1000000011111001ZZZZZZZZ" ,   --18 
 "1001000011111001ZZZZZZZZ" ,   --19 
 "1100000010100100ZZZZZZZZ" ,   --20 
 "1111100110100100ZZZZZZZZ" ,   --21 
 "1010010010100100ZZZZZZZZ" ,   --22 
 "1011000010100100ZZZZZZZZ" ,   --23 
 "1001100110100100ZZZZZZZZ" ,   --24 
 "1001001010100100ZZZZZZZZ" ,   --25 
 "1000001010100100ZZZZZZZZ" ,   --26 
 "1111100010100100ZZZZZZZZ" ,   --27 
 "1000000010100100ZZZZZZZZ" ,   --28 
 "1001000010100100ZZZZZZZZ" ,   --29 
 "1100000010110000ZZZZZZZZ" ,   --30 
 "1111100110110000ZZZZZZZZ" ,   --31 
 "1010010010110000ZZZZZZZZ" ,   --32 
 "1011000010110000ZZZZZZZZ" ,   --33 
 "1001100110110000ZZZZZZZZ" ,   --34 
 "1001001010110000ZZZZZZZZ" ,   --35 
 "1000001010110000ZZZZZZZZ" ,   --36 
 "1111100010110000ZZZZZZZZ" ,   --37 
 "1000000010110000ZZZZZZZZ" ,   --38 
 "1001000010110000ZZZZZZZZ" ,   --39 
 "1100000010011001ZZZZZZZZ" ,   --40 
 "1111100110011001ZZZZZZZZ" ,   --41 
 "1010010010011001ZZZZZZZZ" ,   --42 
 "1011000010011001ZZZZZZZZ" ,   --43 
 "1001100110011001ZZZZZZZZ" ,   --44 
 "1001001010011001ZZZZZZZZ" ,   --45 
 "1000001010011001ZZZZZZZZ" ,   --46 
 "1111100010011001ZZZZZZZZ" ,   --47 
 "1000000010011001ZZZZZZZZ" ,   --48 
 "1001000010011001ZZZZZZZZ" ,   --49 
 "1100000010010010ZZZZZZZZ" ,   --50 
 "1111100110010010ZZZZZZZZ" ,   --51 
 "1010010010010010ZZZZZZZZ" ,   --52 
 "1011000010010010ZZZZZZZZ" ,   --53 
 "1001100110010010ZZZZZZZZ" ,   --54 
 "1001001010010010ZZZZZZZZ" ,   --55 
 "1000001010010010ZZZZZZZZ" ,   --56 
 "1111100010010010ZZZZZZZZ" ,   --57 
 "1000000010010010ZZZZZZZZ" ,   --58 
 "1001000010010010ZZZZZZZZ" ,   --59 
 "1100000010000010ZZZZZZZZ" ,   --60 
 "1111100110000010ZZZZZZZZ" ,   --61 
 "1010010010000010ZZZZZZZZ" ,   --62 
 "1011000010000010ZZZZZZZZ" ,   --63 
 "1001100110000010ZZZZZZZZ" ,   --64 
 "1001001010000010ZZZZZZZZ" ,   --65 
 "1000001010000010ZZZZZZZZ" ,   --66 
 "1111100010000010ZZZZZZZZ" ,   --67 
 "1000000010000010ZZZZZZZZ" ,   --68 
 "1001000010000010ZZZZZZZZ" ,   --69 
 "1100000011111000ZZZZZZZZ" ,   --70 
 "1111100111111000ZZZZZZZZ" ,   --71 
 "1010010011111000ZZZZZZZZ" ,   --72 
 "1011000011111000ZZZZZZZZ" ,   --73 
 "1001100111111000ZZZZZZZZ" ,   --74 
 "1001001011111000ZZZZZZZZ" ,   --75 
 "1000001011111000ZZZZZZZZ" ,   --76 
 "1111100011111000ZZZZZZZZ" ,   --77 
 "1000000011111000ZZZZZZZZ" ,   --78 
 "1001000011111000ZZZZZZZZ" ,   --79 
 "1100000010000000ZZZZZZZZ" ,   --80 
 "1111100110000000ZZZZZZZZ" ,   --81 
 "1010010010000000ZZZZZZZZ" ,   --82 
 "1011000010000000ZZZZZZZZ" ,   --83 
 "1001100110000000ZZZZZZZZ" ,   --84 
 "1001001010000000ZZZZZZZZ" ,   --85 
 "1000001010000000ZZZZZZZZ" ,   --86 
 "1111100010000000ZZZZZZZZ" ,   --87 
 "1000000010000000ZZZZZZZZ" ,   --88 
 "1001000010000000ZZZZZZZZ" ,   --89 
 "1100000010010000ZZZZZZZZ" ,   --90 
 "1111100110010000ZZZZZZZZ" ,   --91 
 "1010010010010000ZZZZZZZZ" ,   --92 
 "1011000010010000ZZZZZZZZ" ,   --93 
 "1001100110010000ZZZZZZZZ" ,   --94 
 "1001001010010000ZZZZZZZZ" ,   --95 
 "1000001010010000ZZZZZZZZ" ,   --96 
 "1111100010010000ZZZZZZZZ" ,   --97 
 "1000000010010000ZZZZZZZZ" ,   --98 
 "1001000010010000ZZZZZZZZ" ,   --99 
 "110000001100000011111001" ,   --100 
 "111110011100000011111001" ,   --101 
 "101001001100000011111001" ,   --102 
 "101100001100000011111001" ,   --103 
 "100110011100000011111001" ,   --104 
 "100100101100000011111001" ,   --105 
 "100000101100000011111001" ,   --106 
 "111110001100000011111001" ,   --107 
 "100000001100000011111001" ,   --108 
 "100100001100000011111001" ,   --109 
 "110000001111100111111001" ,   --110 
 "111110011111100111111001" ,   --111 
 "101001001111100111111001" ,   --112 
 "101100001111100111111001" ,   --113 
 "100110011111100111111001" ,   --114 
 "100100101111100111111001" ,   --115 
 "100000101111100111111001" ,   --116 
 "111110001111100111111001" ,   --117 
 "100000001111100111111001" ,   --118 
 "100100001111100111111001" ,   --119 
 "110000001010010011111001" ,   --120 
 "111110011010010011111001" ,   --121 
 "101001001010010011111001" ,   --122 
 "101100001010010011111001" ,   --123 
 "100110011010010011111001" ,   --124 
 "100100101010010011111001" ,   --125 
 "100000101010010011111001" ,   --126 
 "111110001010010011111001" ,   --127 
 "100000001010010011111001" ,   --128 
 "100100001010010011111001" ,   --129 
 "110000001011000011111001" ,   --130 
 "111110011011000011111001" ,   --131 
 "101001001011000011111001" ,   --132 
 "101100001011000011111001" ,   --133 
 "100110011011000011111001" ,   --134 
 "100100101011000011111001" ,   --135 
 "100000101011000011111001" ,   --136 
 "111110001011000011111001" ,   --137 
 "100000001011000011111001" ,   --138 
 "100100001011000011111001" ,   --139 
 "110000001001100111111001" ,   --140 
 "111110011001100111111001" ,   --141 
 "101001001001100111111001" ,   --142 
 "101100001001100111111001" ,   --143 
 "100110011001100111111001" ,   --144 
 "100100101001100111111001" ,   --145 
 "100000101001100111111001" ,   --146 
 "111110001001100111111001" ,   --147 
 "100000001001100111111001" ,   --148 
 "100100001001100111111001" ,   --149 
 "110000001001001011111001" ,   --150 
 "111110011001001011111001" ,   --151 
 "101001001001001011111001" ,   --152 
 "101100001001001011111001" ,   --153 
 "100110011001001011111001" ,   --154 
 "100100101001001011111001" ,   --155 
 "100000101001001011111001" ,   --156 
 "111110001001001011111001" ,   --157 
 "100000001001001011111001" ,   --158 
 "100100001001001011111001" ,   --159 
 "110000001000001011111001" ,   --160 
 "111110011000001011111001" ,   --161 
 "101001001000001011111001" ,   --162 
 "101100001000001011111001" ,   --163 
 "100110011000001011111001" ,   --164 
 "100100101000001011111001" ,   --165 
 "100000101000001011111001" ,   --166 
 "111110001000001011111001" ,   --167 
 "100000001000001011111001" ,   --168 
 "100100001000001011111001" ,   --169 
 "110000001111100011111001" ,   --170 
 "111110011111100011111001" ,   --171 
 "101001001111100011111001" ,   --172 
 "101100001111100011111001" ,   --173 
 "100110011111100011111001" ,   --174 
 "100100101111100011111001" ,   --175 
 "100000101111100011111001" ,   --176 
 "111110001111100011111001" ,   --177 
 "100000001111100011111001" ,   --178 
 "100100001111100011111001" ,   --179 
 "110000001000000011111001" ,   --180 
 "111110011000000011111001" ,   --181 
 "101001001000000011111001" ,   --182 
 "101100001000000011111001" ,   --183 
 "100110011000000011111001" ,   --184 
 "100100101000000011111001" ,   --185 
 "100000101000000011111001" ,   --186 
 "111110001000000011111001" ,   --187 
 "100000001000000011111001" ,   --188 
 "100100001000000011111001" ,   --189 
 "110000001001000011111001" ,   --190 
 "111110011001000011111001" ,   --191 
 "101001001001000011111001" ,   --192 
 "101100001001000011111001" ,   --193 
 "100110011001000011111001" ,   --194 
 "100100101001000011111001" ,   --195 
 "100000101001000011111001" ,   --196 
 "111110001001000011111001" ,   --197 
 "100000001001000011111001" ,   --198 
 "100100001001000011111001" ,   --199 
 "110000001100000010100100" ,   --200 
 "111110011100000010100100" ,   --201 
 "101001001100000010100100" ,   --202 
 "101100001100000010100100" ,   --203 
 "100110011100000010100100" ,   --204 
 "100100101100000010100100" ,   --205 
 "100000101100000010100100" ,   --206 
 "111110001100000010100100" ,   --207 
 "100000001100000010100100" ,   --208 
 "100100001100000010100100" ,   --209 
 "110000001111100110100100" ,   --210 
 "111110011111100110100100" ,   --211 
 "101001001111100110100100" ,   --212 
 "101100001111100110100100" ,   --213 
 "100110011111100110100100" ,   --214 
 "100100101111100110100100" ,   --215 
 "100000101111100110100100" ,   --216 
 "111110001111100110100100" ,   --217 
 "100000001111100110100100" ,   --218 
 "100100001111100110100100" ,   --219 
 "110000001010010010100100" ,   --220 
 "111110011010010010100100" ,   --221 
 "101001001010010010100100" ,   --222 
 "101100001010010010100100" ,   --223 
 "100110011010010010100100" ,   --224 
 "100100101010010010100100" ,   --225 
 "100000101010010010100100" ,   --226 
 "111110001010010010100100" ,   --227 
 "100000001010010010100100" ,   --228 
 "100100001010010010100100" ,   --229 
 "110000001011000010100100" ,   --230 
 "111110011011000010100100" ,   --231 
 "101001001011000010100100" ,   --232 
 "101100001011000010100100" ,   --233 
 "100110011011000010100100" ,   --234 
 "100100101011000010100100" ,   --235 
 "100000101011000010100100" ,   --236 
 "111110001011000010100100" ,   --237 
 "100000001011000010100100" ,   --238 
 "100100001011000010100100" ,   --239 
 "110000001001100110100100" ,   --240 
 "111110011001100110100100" ,   --241 
 "101001001001100110100100" ,   --242 
 "101100001001100110100100" ,   --243 
 "100110011001100110100100" ,   --244 
 "100100101001100110100100" ,   --245 
 "100000101001100110100100" ,   --246 
 "111110001001100110100100" ,   --247 
 "100000001001100110100100" ,   --248 
 "100100001001100110100100" ,   --249 
 "110000001001001010100100" ,   --250 
 "111110011001001010100100" ,   --251 
 "101001001001001010100100" ,   --252 
 "101100001001001010100100" ,   --253 
 "100110011001001010100100" ,   --254 
 "100100101001001010100100"     --255 
 

  );

begin

  Cur_D_Val_SS_out <= ROM_Data (Cur_D_Val_Out);

end struct;