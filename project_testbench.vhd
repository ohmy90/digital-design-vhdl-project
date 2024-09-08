library ieee;
use ieee.std_logic_1164.all;
entity project_testbench is
end project_testbench;

architecture tb of project_testbench is
	component project
		port(
			clk, reset: in std_logic;
			x,y	: in std_logic_vector (6 downto 0);
			z	: out std_logic;
			q_occ,q_occ_max	: out std_logic_vector (6 downto 0));
	end component;
	signal test_clk: std_logic;
	signal test_r: std_logic;
	signal test_x: std_logic_vector (6 downto 0);
	signal test_y: std_logic_vector (6 downto 0);
	signal test_z: std_logic;
	signal test_q_occ: std_logic_vector (6 downto 0);
	signal test_q_occ_max: std_logic_vector (6 downto 0);

begin

	uut: project
		port map( clk=>test_clk, reset=>test_r, x=>test_x, y=>test_y, z=>test_z,
			  q_occ=>test_q_occ, q_occ_max=>test_q_occ_max);
		process
		begin
		test_r<='0';
		test_clk<='0';
		test_x<="0000000";
		test_y<="0000000";
		wait for 20 ns;
		test_r<='1';
		wait for 20 ns;
		test_r<='0';
		wait for 20 ns;
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;
		

		test_clk<='1';
		test_x<="0000001";
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;
		
		test_x<="0000000";
		test_y<="0000001";
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;
		
		test_x<="0100000";
		test_y<="0001000";
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;

		test_x<="0111111";
		test_y<="0000000";
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;
		test_x<="0000001";
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;

		test_x<="0000000";
		test_y<="0001000";
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;

		test_x<="0001000";
		test_y<="0000000";
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;

		test_x<="0000000";
		test_y<="0111111";
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;
		

		test_x<="0000010";
		test_y<="0000000";
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;
		test_clk<='1';
		wait for 20 ns;
		test_clk<='0';
		wait for 20 ns;
		


		end process;

		process
			variable error_status:	boolean;
		begin
			wait on test_r;
			wait on test_clk;
			wait on test_x;
			wait on test_y;
			wait for 10 ns;

		if ((test_x="0000000" and test_y="0111111" and test_q_occ/="0000000") or
			(test_x="0111111" and test_y="0000000" and test_q_occ/="0111111") or
			(test_r='1' and test_q_occ/="0000000"and test_q_occ_max/="0111111"))
		then
			error_status:= true;
		else
			error_status:=false;
		end if;
		assert not error_status
			report "test successful"
			severity note;
		end process;
	end tb;
			

		
