----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Emre ASLAN



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is

generic(
clk_freq : integer := 100_000_000
);

Port(
clk : in std_logic;
reset : in std_logic;
sw_i : in std_logic_vector(15 downto 0);
led_o : out std_logic_vector(15 downto 0);
seven_seg_o : out std_logic_vector(6 downto 0);
anode_o : out std_logic_vector(3 downto 0)
);
end top;

architecture Behavioral of top is

------------Counter 20 Sec Module
component counterModule is

generic(
clk_freq : integer := 100_000_000
);

Port (
clk : in std_logic := '0';
reset : in std_logic := '0';
count_out: out std_logic_vector(4 downto 0)
 );
end component;

------------- Whack Mole Main Module----------------
component whackGame is

generic(numberOfBits : integer := 4
);

Port ( 
clk: in std_logic;
reset: in std_logic;
sw_i: in std_logic_vector(15 downto 0);
led_o: out std_logic_vector(15 downto 0);
score_o: out std_logic_vector(5 downto 0)
 
 );
end component;

----------- Binary to BCD Module------------------

component bcdModule is
Port (
count_i : in std_logic_vector(4 downto 0);
score_i : in std_logic_vector(5 downto 0);
score_out1: out std_logic_vector(5 downto 0);
score_out2: out std_logic_vector(5 downto 0);
count_out1: out std_logic_vector(5 downto 0);
count_out2: out std_logic_vector(5 downto 0)
);
end component;

------------ 4x1 MUX --------------
component fourtooneMUX is
Port(
count_1 : in std_logic_vector(5 downto 0);
count_2 : in std_logic_vector(5 downto 0);
score_1 : in std_logic_vector(5 downto 0);
score_2 : in std_logic_vector(5 downto 0);
select_i: in std_logic_vector(3 downto 0);
mux_o : out std_logic_vector(5 downto 0)
);
end component;

------------ BCD to Seven Segment-------------
component sevenSegment is
Port 
(bcd_inp : in std_logic_vector(5 downto 0);
 bcd_out : out std_logic_vector(6 downto 0)  
  );
end component;

    ------------- Signals-----------
---------Counter 20 Secs---------------
signal count_out : std_logic_vector(4 downto 0);

--------- Whack A Mole ---------------
signal score_o : std_logic_vector(5 downto 0) := (others => '0');

--------- BCD Module--------------
signal score_out1 : std_logic_vector(5 downto 0) := (others => '0');
signal score_out2 : std_logic_vector(5 downto 0) := (others => '0');
signal count_out1 : std_logic_vector(5 downto 0) := (others => '0');
signal count_out2 : std_logic_vector(5 downto 0) := (others => '0');


---------- MUX_ 4X1---------
signal mux_o : std_logic_vector(5 downto 0) := (others => '0');
signal select_i : std_logic_vector(3 downto 0) := ("0001");

----------BCDtoSevenSegment--------



--------------Signals for 1ms Counter------------
constant countLim_1ms : integer := clk_freq/1000;
signal counter_1ms : integer range 0 to countLim_1ms := 0;
signal anode_output : std_logic_vector(3 downto 0):= "1110";

begin


----------- Counter 20 Secs Mapping------------
counter:  counterModule 

generic map(
clk_freq => clk_freq
)
Port map(
clk  => clk,
reset => reset,
count_out => count_out
 );


-------------Whack a Mole Map----------------
whackGame1: whackGame 

generic map(
numberOfBits => 4
)

Port map ( 
clk => clk,
reset => reset,
sw_i => sw_i,
led_o => led_o,
score_o =>score_o
 );


BCD_map: bcdModule 
Port map (
count_i => count_out,
score_i =>score_o,
score_out1 =>score_out1,
score_out2 =>score_out2,
count_out1 =>count_out1,
count_out2 =>count_out2
);

MUX_map:  fourtooneMUX 
Port map(
count_1 => count_out1,
count_2 => count_out2,
score_1 =>score_out1,
score_2 => score_out2,
select_i =>select_i,
mux_o  => mux_o
);

bcd_toSeven:  sevenSegment 
Port map 
(bcd_inp => mux_o,
 bcd_out => seven_seg_o
  );


--------Anode Process---------

anodeProcess: process(clk) begin
    if(rising_edge(clk)) then
    
    
    if(counter_1ms >= countLim_1ms-1) then
        anode_output(3 downto 1) <= anode_output(2 downto 0);
        anode_output(0) <=  anode_output(3);
        
        select_i(3 downto 1) <= select_i(2 downto 0);
        select_i(0) <=  select_i(3); 
        counter_1ms <= 0; 
   else
       counter_1ms <= counter_1ms + 1;     
   end if;    
    end if;
end process;


anode_o <= anode_output;


end Behavioral;
