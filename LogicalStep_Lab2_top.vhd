library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


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
-- Components Used ---
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
	logic_in0 : in std_logic_vector(3 downto 0);
	logic_in1										: in std_logic_vector(3 downto 0);
	logic_out											:out std_logic_vector(3 downto 0);
	logic_select : in std_logic_vector(0 downto 1)
   ); 
   end component;
	
	component PB_Inverters port (
	pbn : IN std_logic_vector(3 downto 0);
	pbo : OUT std_logic_vector(3 downto 0)
	);
	end component;
	
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal hex_A		: std_logic_vector(3 downto 0);
	
	signal seg7_B		: std_logic_vector(6 downto 0);
	signal hex_B		: std_logic_vector(3 downto 0);
	
	signal logic_selector		: std_logic_vector(1 downto 0);
	
	signal pb : std_logic_vector(3 downto 0);
	
	
-- Here the circuit begins

begin

	hex_A <= SW(3 downto 0);
	hex_B <= SW(7 downto 4);
	--leds(0) <= pb(0);
	--leds(1) <= pb(1);
	--leds(2) <= pb(2);
	--leds(3) <= pb(3);
	--seg7_data <= seg7_A;
	
	INST1: SevenSegment port map(hex_A, seg7_A);
	
	INST2: SevenSegment port map(hex_B, seg7_B);

	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
	
	INST4: LogicProcessorMUX port map(hex_A, hex_B, leds(3 downto 0), pb(1 downto 0));
	
	INST5: PB_Inverters port map(pb_n, pb);
 
end SimpleCircuit;

