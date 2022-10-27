----------------------------------------------------------------------------------
-- Company: 
-- Engineer:  Emre ASLAN
-- 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;



entity whackGame is

generic(numberOfBits : integer := 4
);

Port ( 
clk: in std_logic;
reset: in std_logic;
sw_i: in std_logic_vector(15 downto 0);
led_o: out std_logic_vector(15 downto 0) := (others => '0');
score_o: out std_logic_vector(5 downto 0):= (others => '0')
 
 );
end whackGame;

architecture Behavioral of whackGame is


component LSFR is
generic(
numberofBits : integer := 4
);

Port( 
clk: in std_logic;
load_i: in std_logic;
enable_i: in std_logic;
number_o : out std_logic_vector(3 downto 0)
);
end component;
--------------Signal Declerations -------------------

signal load_inp : std_logic := '0';
--signal enable_inp : std_logic := '0';
signal number_out: std_logic_vector(3 downto 0) := "0101";

signal sw_prev : std_logic:= '0';
signal score_out : integer := 0;


------------Memory Definition----------------------
type mem_type is array (0 to 15) of std_logic_vector(15 downto 0);
signal led_mem: mem_type := (
                             0 => "0000000000000001",
                             1 => "0000000000000010",
                             2 => "0000000000000100",
                             3 => "0000000000001000",
                             4 => "0000000000010000",
                             5 => "0000000000100000",
                             6 => "0000000001000000",
                             7 => "0000000010000000",
                             8 => "0000000100000000",
                             9 => "0000001000000000",
                             10=> "0000010000000000",
                             11=> "0000100000000000",
                             12=> "0001000000000000",
                             13=> "0010000000000000",
                             14=> "0100000000000000",
                             15=> "1000000000000000",
                            others => (others => '0' ) );
begin

LSFR_MAP: LSFR 
generic map(
numberofBits =>numberofBits
)
Port map( 
clk => clk,
load_i =>load_inp,
enable_i => '1',
number_o => number_out
);


process (clk) begin



    if(rising_edge(clk)) then
    
      led_o <= led_mem(to_integer(unsigned(number_out)));   
      sw_prev <= sw_i(to_integer(unsigned(number_out)));
      load_inp  <= '0';
       
      if( (sw_prev = '0' and sw_i(to_integer(unsigned(number_out))) = '1'  )  ) then --or (sw_prev = '1' and sw_i(to_integer(unsigned(number_out))) = '0')
          load_inp  <= '1';
          score_out <= score_out + 1;
      end if;
      
      if(score_out > 39) then
      score_out <= 0;
      end if;
      
    if(reset = '1') then
    score_out <= 0;
    end if;
      
    end if;
end process;

score_o <=std_logic_vector(to_unsigned(score_out, score_o'length));  --std_logic_vector(to_unsigned(input_1, output_1a'length));

end Behavioral;
