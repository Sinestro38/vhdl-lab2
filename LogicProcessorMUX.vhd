library ieee;
use ieee.std_logic_1164.all;

-- Anthony Zhenakov and Pavan Jayasinha
-- Group 20 | Lab 2

entity LogicProcessorMUX is
port (
	logic_in0, logic_in1 : in std_logic_vector(3 downto 0); -- two input busses (operands)
	logic_out				: out std_logic_vector(3 downto 0);-- output bus (result of the operation on the two inputs)
	logic_select 			: in std_logic_vector(1 downto 0)  -- two select bits to select mux output
);

end LogicProcessorMUX;

architecture processor_logic of LogicProcessorMUX is
begin

-- Select which input of the mux to be the output by looking at "logic_select" 
with logic_select select
-- Perform required Logic Processor operations and set the output of this mux
logic_out <= 	(logic_in0 AND logic_in1) when "00",
					(logic_in0 OR logic_in1) when "01",
					(logic_in0 XOR logic_in1) when "10",
					(logic_in0 XNOR logic_in1) when "11";
end processor_logic;