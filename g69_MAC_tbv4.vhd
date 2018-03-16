library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity g69_MAC_tbv4 is
end g69_MAC_tbv4;

architecture test of g69_MAC_tbv4 is


	
component lab_v2 is 
port (
	x 	: in std_logic_vector (9 downto 0);
	y 	: in std_logic_vector (9 downto 0);
	N 	: in std_logic_vector (9 downto 0);
	clk 	: in std_logic;
	rst 	: in std_logic;
	mac 	: out std_logic_vector (19 downto 0);
	ready 	: out std_logic);
	
end component lab_v2;

file file_VECTORS_X : text;
file file_VECTORS_Y : text;
file file_RESULTS   : text;

constant clk_PERIOD : time := 100 ns;

signal x_in 	:  std_logic_vector (9 downto 0);
signal y_in 	:  std_logic_vector (9 downto 0);
signal N_in 	:  std_logic_vector (9 downto 0);
signal clk 	:  std_logic;
signal rst 	:  std_logic;
signal mac_out  :  std_logic_vector (19 downto 0);
signal ready_out:  std_logic;

begin

	MAC_inst : lab_v2
		port map (
			x 	=> x_in,
			y 	=> y_in,
			N 	=> N_in,
			clk 	=> clk,
			rst 	=> rst,
			mac 	=> mac_out,
			ready 	=> ready_out
);

clk_generation : process
begin 
	clk <= '1';
	wait for clk_PERIOD/2;
	clk <= '0';
	wait for clk_PERIOD/2;
end process clk_generation;

feeding_instr : process is 
	variable v_Iline1 : line;
	variable v_Iline2 : line;
	variable v_Oline  : line;
	variable v_x_in   : std_logic_vector(9 downto 0);
	variable v_y_in   : std_logic_vector(9 downto 0);
 
begin 
	N_in <= "1111101000"; 
	rst <= '1';
	wait until rising_edge(clk);
	wait until rising_edge(clk);
	rst <= '0';

	file_open (file_VECTORS_X, "P:\lab2v4\x-formatted-3.txt", read_mode);
	file_open (file_VECTORS_Y, "P:\lab2v4\y-formatted-3.txt", read_mode);
	file_open (file_RESULTS, "P:\lab2v4\lab2-out.txt", write_mode);

	ready_out <= '1';

	while not endfile (file_VECTORS_X) loop
		readline(file_VECTORS_X, v_Iline1);
		read(v_Iline1, v_x_in);
		readline(file_VECTORS_Y, v_Iline2);
		read(v_Iline2, v_y_in);

		x_in <= v_x_in;
		y_in <= v_y_in;

		write(v_Oline, mac_out);
       		writeline(file_RESULTS, v_Oline);

		wait until rising_edge(clk);
	end loop;

	
	wait;

end process feeding_instr;

end architecture test;