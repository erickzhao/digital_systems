library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity vhdl1 is
	port( clk			:in std_logic;
			direction 	:in std_logic;
			rst			:in std_logic;
			enable		:in std_logic;
			output		:out std_logic_vector(15 downto 0));
end vhdl1;

architecture counter69 of vhdl1 is
signal count: unsigned(15 downto 0);
begin

process(clk)
begin
	
if rising_edge(clk) then
	if rst ='1' then 
		count <= x"0000";
	
	elsif enable ='1' then
		if direction ='1' then count <= count + 1;
			else count <= count - 1;
			
			end if;
		end if;
	end if;

end process;

output <= std_logic_vector(count);

end counter69;

