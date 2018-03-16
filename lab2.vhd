library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab_v2 is

port(	x 	: in 	std_logic_vector(9 downto 0);
	y 	: in 	std_logic_vector(9 downto 0);
	N 	: in 	std_logic_vector(9 downto 0);
	clk 	: in 	std_logic;
	rst 	: in 	std_logic;
	mac 	: out 	std_logic_vector(19 downto 0);
	ready 	: out 	std_logic);
end lab_v2;

architecture MAC of lab_v2 is
	signal mac_out : signed(19 downto 0);
	begin
	process(clk)
	begin
		ready <= '0';
		if rst = '1' then
			 mac_out <= (others => '0');
		elsif rising_edge(clk) then
			mac_out <= mac_out + (signed(x)*signed(y));
		end if;
		ready <= '1';
	end process;
	mac <= std_logic_vector(mac_out);
end MAC;
