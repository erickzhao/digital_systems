library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab3 is
port (  x       : in    std_logic_vector (15 downto 0);
        clk     : in    std_logic;
        rst     : in    std_logic;
        y       : out   std_logic_vector (16 downto 0));
end lab3;

architecture FIR of lab3 is
	type A_DATA is array(0 to 24)
			of std_logic_vector(15 downto 0);
	signal x_mem	: A_DATA;
	signal y_out 	: signed(16 downto 0) := (others => '0');
	constant TAPS 	: A_DATA := 
	(
"0000001001110010",

"0000000000010001",

"1111111111010011",

"1111111011011110",

"0000001100011001",

"1111110110100111",

"1111110000001110",

"0000110110111100",

"1110110001110011",

"0000110111110111",

"0000001100000111",

"1110101000001010",

"0001111000110011",

"1110101000001010",

"0000001100000111",

"0000110111110111",

"1110110001110011",

"0000110110111100",

"1111110000001110",

"1111110110100111",

"0000001100011001",

"1111111011011110",

"1111111111010011",

"0000000000010001",

"0000001001110010"

);
	begin
	
	process(rst,clk)
	variable tmp	: signed(31 downto 0);
	variable tmp2	: std_logic_vector(31 downto 0);
	variable tmp3	: std_logic_vector(16 downto 0);
	begin
		if rst = '1' then
			x_mem <= (others => "0000000000000000");
		elsif rising_edge(clk) then
			x_mem(0) <= x;
			for I in 0 to 24 loop
				tmp2  := std_logic_vector(signed(x_mem(I))*signed(TAPS(I)));
				tmp3  := tmp2(31 downto 15);
				y_out <= y_out + signed(tmp3);
			end loop;
			for J in 0 to 23 loop
				x_mem(J+1) <= x_mem(J);
			end loop;
		end if;
	end process;
	y <= std_logic_vector(y_out);
end FIR;