----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Emre ASLAN

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity LSFR is
generic(
numberofBits : integer := 3
);

Port ( 
clk: in std_logic;
load_i: in std_logic;
enable_i: in std_logic;
number_o : out std_logic_vector(3 downto 0)
 );
end LSFR;

architecture Behavioral of LSFR is

signal prev_load : std_logic := '0';
signal psuedo_generated : std_logic_vector(3 downto 0) := "0101";
signal number_out : std_logic_vector(3 downto 0) := "0101";

begin


process (clk) begin

    if(rising_edge(clk)) then   
    prev_load <= load_i;
    
    if(enable_i = '1') then
    psuedo_generated(3 downto 1) <= psuedo_generated(2 downto 0);
    psuedo_generated(0) <= psuedo_generated(3) xor psuedo_generated(2); 
    end if;
    
    if(load_i = '1' and prev_load = '0') then
    number_out <= psuedo_generated;
    end if;
  
  end if;

end process;

number_o <= number_out;

end Behavioral;
