----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Emre ASLAN



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity counterModule is

generic(
clk_freq : integer := 100_000_000
);

Port (
clk : in std_logic := '0';
reset : in std_logic := '0';
count_out: out std_logic_vector(4 downto 0)
 );
end counterModule;

architecture Behavioral of counterModule is


signal counter_1sec : integer range 0 to clk_freq-1 := 0;
signal counter_out : integer  range 0 to 20:= 19;


begin

main_counter: process (clk,reset) begin
    
  if(reset = '1') then
  counter_1sec <= 0;
  counter_out <= 19;
--count_out <= "00000";
  end if;
  if(rising_edge(clk))  then
      
     if (counter_out > 0) then     
     
        if(counter_1sec >= clk_freq-1 ) then        
            counter_1sec <= 0;
            counter_out <= counter_out -1;         
        else
            counter_1sec <= counter_1sec + 1;           
        end if;
        
     end if;      
 end if;
   end process;

count_out <= std_logic_vector(to_unsigned(counter_out, count_out'length));

end Behavioral;
