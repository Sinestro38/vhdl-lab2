library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Anthony Zhenakov and Pavan Jayasinha
-- Group 20 | Lab 2

entity LogicalStep_Lab2_top is port ( 
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Declaring the components that are used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
	clk : in std_logic := '0';	
	DIN2 : in std_logic_vector(6 downto 0);
	DIN1: in std_logic_vector(6 downto 0);
	DOUT : out std_logic_vector(6 downto 0);
	DIG2 : out std_logic;
	DIG1 : out std_logic
   ); 
   end component;
	
	component LogicProcessorMUX port (
	logic_in0, logic_in1		: in std_logic_vector(3 downto 0);	--The four bit operand inputs
	logic_out		: out std_logic_vector(3 downto 0);	-- Output of LogicProcessor mux
	logic_select 	: in std_logic_vector(1 downto 0)	-- Two select bits for the mux
   ); 
   end component;
	
	component PB_Inverters port (
	pbn : IN std_logic_vector(3 downto 0); -- 4bit signal to be inverted
	pbo : OUT std_logic_vector(3 downto 0) -- 4bit inverted signal
	);
	end component;
	
	component full_adder_4bit port (
	bus0, bus1: in std_logic_vector(3 downto 0);				-- 4bit inputs that are added together
	input_carry : in std_logic;									-- Carry input that is added with other inputs
	full_adder_carry_out : out std_logic;						-- Carry output of the adder
	full_adder_sum_out : out std_logic_vector(3 DOWNTO 0)	-- Sum output of adder
	);
	end component;
	
	component mux21_4bit port (
	hex_num1, hex_num2 	: in std_logic_vector(3 downto 0);	-- 4bit input busses that are selected by the mux
	mux_select				: in std_logic;							-- Mux single select bit
	hex_out					:out std_logic_vector(3 downto 0)	--	Output of the mux
	);
	end component;
	
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--

	-- These two signals are translations of some binary values to a hex character on a seven segment display
	-- the index which has a '1' corresponds to which light on the seven-seg will light up
	signal seg7_A, seg7_B		: std_logic_vector(6 downto 0);
	
	-- These signals are associated with your physical switch inputs
	-- when a switch is on, the corresponding index has a '1' in it
	signal hex_A, hex_B	: std_logic_vector(3 downto 0);
	
		--Inverted push button
	signal pb : std_logic_vector(3 downto 0);
	
	-- Signal that stores the carry from the 4 bit adder
	signal adder_carry: std_logic;
	-- Signal that stores the sum std_logic_vector of the adder
	signal adder_sum	: std_logic_vector(3 downto 0);
	
	--The hex value that is shown on the first seven segment display
	signal seven_seg1 :std_logic_vector(3 downto 0);
	--The hex value that is shown on the second seven segment display
	signal seven_seg2 :std_logic_vector(3 downto 0);
	
	
	
-- Here the circuit begins

begin
	--Assigning switch inputs to hex signals
	hex_A <= SW(3 downto 0);
	hex_B <= SW(7 downto 4);
	
	-- Display data on seven segment displays
	INST1: SevenSegment port map(seven_seg2, seg7_A);
	INST2: SevenSegment port map(seven_seg1, seg7_B);
	
	--Component which sets the states of the seven segment displays
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
	
	--Component which performs logical operations on hex_A and hex_B, and shows the output on the leds
	INST4: LogicProcessorMUX port map(hex_A, hex_B, leds(3 downto 0), pb(1 downto 0));
	
	--Invert the push button inputs
	INST5: PB_Inverters port map(pb_n, pb);
	
	--Component which adds hex_A and hex_B values - outputs a carry bit and a 4-bit sum
	INST6: full_adder_4bit port map(hex_A, hex_B, '0', adder_carry, adder_sum); 
	
	
	-- Select what is shown on seven segment displays
	-- (the same 1 bit select signal is used for two 2-1 4bit muxes) 
	-- we need to either show Operand A AND Operand B
	-- or the sum of Operand A and Operand B (hex_A and hex_B)
	
	-- Either hex_B or the carry from the adder is shown on digit 1 
	--(we weren't told whether the concatenation operator is a dataflow construct or not... We were told to connect the output straight to the component instance)
	INST7: mux21_4bit port map(hex_B, "000" & adder_carry, pb(2), seven_seg1);
	--Either hex_A or the sum from the adder is shown on digit 2
	INST8: mux21_4bit port map(hex_A, adder_sum, pb(2), seven_seg2);
 
end SimpleCircuit;

