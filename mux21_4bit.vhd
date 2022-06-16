library ieee;
use ieee.std_logic_1164.all;

-- Anthony Zhenakov and Pavan Jayasinha
-- Group 20 | Lab 2

entity mux21_4bit is
port (
	hex_num1, hex_num2 	: in std_logic_vector(3 downto 0); -- hex input busses
	mux_select				: in std_logic;						  -- single select bit
	hex_out					:out std_logic_vector(3 downto 0)  -- hex output bus
);

end mux21_4bit;

architecture mux_logic of mux21_4bit is
begin

-- this is for the multiplexing of two hex input busses
--(select which input will be the output)
with mux_select select
hex_out <= 	hex_num1 when '0',
				hex_num2 when '1';

end mux_logic;