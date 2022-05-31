library ieee;
use ieee.std_logic_1164.all;

entity PB_Inverters is
port (
	pbn : IN std_logic_vector(3 downto 0);
	pbo : OUT std_logic_vector(3 downto 0)
);

end PB_Inverters;

architecture gates of PB_Inverters is
begin

pbo <= not(pbn);
end gates;