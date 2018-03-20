library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab4 is
port (  x       : in    std_logic_vector (15 downto 0);
        clk     : in    std_logic;
        rst     : in    std_logic;
        y       : out   std_logic_vector (15 downto 0));
end lab4;

architecture FIR of lab4 is
	type A_DATA is array(0 to 24)
			of std_logic_vector(15 downto 0);
	signal x_in		: std_logic_vector(15 downto 0);
	signal regs		: A_DATA;
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
	variable prod	: std_logic_vector(31 downto 0);
	variable trunc	: std_logic_vector(15 downto 0);

	begin
		if rst = '1' then
			-- what do i put here
		elsif rising_edge(clk) then
			x_in <= x;
			prod 	:= std_logic_vector(signed(x_in)*signed(TAPS(24)));
			trunc :=	prod(31 downto 16);
			regs(0) <= trunc;
			for I in 1 to 24 loop
				prod  	:= std_logic_vector((signed(x_in))*signed(TAPS(24-I)));
				trunc 	:= prod(31 downto 16);
				regs(I) 	<= std_logic_vector(signed(regs(I-1)) + signed(trunc));
			end loop;
		end if;
	end process;
	y <= regs(24);
end FIR;
