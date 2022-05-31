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

pbo(0) <= not pbn(0);
pbo(1) <= not pbn(1);
pbo(2) <= not pbn(2);
pbo(3) <= not pbn(3);

end gates;