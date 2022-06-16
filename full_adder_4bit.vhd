library ieee;
use ieee.std_logic_1164.all;

-- Anthony Zhenakov and Pavan Jayasinha
-- Group 20 | Lab 2

entity full_adder_4bit is
port (
	--4bit bus inputs whose values will be added together
	--(bus0 values are added with bus1)s
	bus0, bus1 : in std_logic_vector(3 downto 0);
	
	--The carry input bit of the 4 bit adder 
	--(not used in this lab because we're not daisy-chaining adders)
	input_carry : in std_logic;

	--Carry output bit
	full_adder_carry_out : out std_logic;
	--Sum output bus (4bit value of sum)
	full_adder_sum_out : out std_logic_vector(3 DOWNTO 0)

	);

end full_adder_4bit;

architecture logic_add_4bit of full_adder_4bit is
	
	--These are the carry bits of the first three daisy chained 1bit adders
	signal carry_a : std_logic;
	signal carry_b : std_logic;
	signal carry_c : std_logic;

	--These are the sums of the first three daisy chained 1bit adders
	signal sum_a : std_logic;
	signal sum_b : std_logic;
	signal sum_c : std_logic;
	
	--1bit Full adder component 
	--(has three inputs which are summed up, outputs the sum and the carry bit)
	component full_adder_1bit port (
		input_a : in std_logic;
		input_b : in std_logic;
		input_carry : in std_logic;
	
		full_adder_carry_out : out std_logic;
		full_adder_sum_out : out std_logic
	);
	end component;

begin
	--Daisy-chained 1bit full adders (instantiating them and specifying their inputs/outputs)
	
	--Sums an external carry bit and the least significant bits of the bus0 and bus1 inputs
	INST1 : full_adder_1bit port map(bus0(0), bus1(0), input_carry, carry_a, full_adder_sum_out(0));
	--Sums the next least significant bits and the carry bit of the INST1 adder
	INST2 : full_adder_1bit port map(bus0(1), bus1(1), carry_a, carry_b, full_adder_sum_out(1));
	--Sums the 2nd most significant bits and the carry bit of the INST2 adder
	INST3 : full_adder_1bit port map(bus0(2), bus1(2), carry_b, carry_c, full_adder_sum_out(2));
	--Sums the most significant bits and the carry bit of INST3
	INST4 : full_adder_1bit port map(bus0(3), bus1(3), carry_c, full_adder_carry_out, full_adder_sum_out(3));
	
	--The sum of the bus0(i) and bus1(i) inputs will correspond to the "full_adder_sum_out(i)" output
	--And the output of the INST4 full_adder_1bit is the actual carry ouput of this 4bit full adder

end logic_add_4bit;




