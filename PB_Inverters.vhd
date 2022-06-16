library ieee;
use ieee.std_logic_1164.all;

-- Anthony Zhenakov and Pavan Jayasinha
-- Group 20 | Lab 2

entity PB_Inverters is
port (
	--Input that will be inverted
	pbn : IN std_logic_vector(3 downto 0);
	--Inversion of the input bus
	pbo : OUT std_logic_vector(3 downto 0)
);

end PB_Inverters;

architecture gates of PB_Inverters is
begin

--Invert the input
pbo <= not(pbn);


end gates;