library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity lab4_tb is
end lab4_tb;

architecture test of lab4_tb is

component lab4 is
port (  x       : in    std_logic_vector (15 downto 0);
        clk     : in    std_logic;
        rst     : in    std_logic;
        y       : out   std_logic_vector (15 downto 0));
end component lab4;

file file_VECTOR_IN 	: text;
file file_RESULTS 	: text;

constant clk_PERIOD : time := 100 ns;

signal x_in 	: std_logic_vector (15 downto 0);
signal clk	: std_logic;
signal rst	: std_logic;
signal y_out	: std_logic_vector (15 downto 0);

begin
	FIR_inst : lab4
		port map (
			x 	=> x_in,
			clk 	=> clk,
			rst 	=> rst,
			y 	=> y_out
		);

clk_generation : process
begin 
	clk <= '1';
	wait for clk_PERIOD/2;
	clk <= '0';
	wait for clk_PERIOD/2;
end process clk_generation;

feeding_instr : process is 
	variable v_Iline  : line;
	variable v_Oline  : line;
	variable v_x_in   : std_logic_vector(15 downto 0);
begin

	rst <= '1';
	wait until rising_edge(clk);
	wait until rising_edge(clk);
	rst <= '0';
	
	file_open (file_VECTOR_IN, "lab4-formatted.txt", read_mode);
	file_open (file_RESULTS, "lab4-out.txt", write_mode);

	while not endfile (file_VECTOR_IN) loop
		readline(file_VECTOR_IN, v_Iline);
		read(v_Iline, v_x_in);
		
		x_in <= v_x_in;

		write(v_Oline, y_out);
		writeline(file_RESULTS, v_Oline);

		wait until rising_edge(clk);
	end loop;

	wait;
end process feeding_instr;

end architecture test;
			
