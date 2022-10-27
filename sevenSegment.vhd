----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2022 07:28:58 PM
-- Design Name: 
-- Module Name: bcdToSevenSeg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sevenSegment is
Port 
(bcd_inp : in std_logic_vector(5 downto 0);
 bcd_out : out std_logic_vector(6 downto 0)  
  );
end sevenSegment;



architecture Behavioral of sevenSegment is

signal bcd_inpS: std_logic_vector(3 downto 0);

begin

process (bcd_inp) begin

	case bcd_inp is
	
	
		when "000000" =>  --0
		bcd_out <= "0000001";
	
		when "000001" =>  --1
		bcd_out <= "1001111";
		
		when "000010" => --2
		bcd_out <= "0010010"; 
		
		when "000011" => --3
		bcd_out <= "0000110";
		
		when "000100" => --4
		bcd_out <= "1001100";
		
		when "000101" => --5
		bcd_out <= "0100100";
		
		when "000110" => --6 
		bcd_out <= "0100000";
		
		when "000111" => --7
		bcd_out <= "0001111";
		
		when "001000" => --8
		bcd_out <= "0000000";
		
	    when "001001" => --9
		bcd_out <= "0000100";
		
		when others => report "unreachable" severity failure;
	end case;
end process;





end Behavioral;
