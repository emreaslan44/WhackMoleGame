

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fourtooneMUX is
Port(
count_1 : in std_logic_vector(5 downto 0);
count_2 : in std_logic_vector(5 downto 0);
score_1 : in std_logic_vector(5 downto 0);
score_2 : in std_logic_vector(5 downto 0);
select_i: in std_logic_vector(3 downto 0);
mux_o : out std_logic_vector(5 downto 0)
);
end fourtooneMUX;

architecture Behavioral of fourtooneMUX is

begin

process (select_i) begin

case select_i is  
        when "0001" =>
        mux_o <=  count_1;
        
        when "0010" =>
        mux_o <=  count_2;
    
        when "0100" =>
        mux_o <=  score_1;
        
        when "1000" =>
        mux_o <=  score_2;
        when others => report "unreachable" severity failure;
end case;

end process;


end Behavioral;
