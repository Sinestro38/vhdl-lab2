library ieee;
use ieee.std_logic_1164.all;

-- Anthony Zhenakov and Pavan Jayasinha
-- Group 20 | Lab 2

entity full_adder_1bit is
port (
	--The two 1bit inputs to be summed up
	input_a : in std_logic;
	input_b : in std_logic;
	--The carry input
	input_carry : in std_logic;
	
	--The carry output of the 1bit adder
	full_adder_carry_out : out std_logic;
	--The sum output
	full_adder_sum_out : out std_logic
	);

end full_adder_1bit;

architecture logic_add_1bit of full_adder_1bit is
	
	--The full adder contains a half adder inside of it
	signal half_adder_carry_out : std_logic;
	signal half_adder_sum_out 	 : std_logic;

begin
	--Get the output of the half adder
	--(half adder operations are performed)
	half_adder_carry_out <= input_a AND input_b;
	half_adder_sum_out <= input_a XOR input_b;
	
	--Get the output of the full adder
	--(full adder operations are performed)
	full_adder_sum_out <= input_carry XOR half_adder_sum_out;
	full_adder_carry_out <= half_adder_carry_out OR (input_carry AND half_adder_sum_out);

end logic_add_1bit;