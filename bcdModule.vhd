----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Emre ASLAN
-- 



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_unsigned.all;


entity bcdModule is
Port (
count_i : in std_logic_vector(4 downto 0);
score_i : in std_logic_vector(5 downto 0);
score_out1: out std_logic_vector(5 downto 0);
score_out2: out std_logic_vector(5 downto 0);
count_out1: out std_logic_vector(5 downto 0);
count_out2: out std_logic_vector(5 downto 0)
);
end bcdModule;



architecture Behavioral of bcdModule is

begin

process (count_i) begin 
    count_out1 <= "000000";
    count_out2 <= "000010";
if(count_i < "01010") then
    count_out2 <= "000000";
    count_out1 <=  '0'  & count_i;
elsif (count_i > "01010") then
    count_out2 <= "000001";
    count_out1 <= '0' & (count_i - "01010");
end if;

end process;

process (score_i) begin 

if(score_i < "001001") then
    score_out2 <= "000000";
    score_out1 <= score_i;
elsif (score_i < "010100") then
    score_out2 <= "000001";
    score_out1 <= score_i - "001010";
elsif (score_i < "011110") then --16 + 8 + 4 + 2
    score_out2 <= "000010";
    score_out1 <= score_i - "010100"; 
elsif (score_i < "101000") then --32 + 8
    score_out2 <= "000011";
    score_out1 <= score_i - "011110"; 

end if;
end process;
end Behavioral;
