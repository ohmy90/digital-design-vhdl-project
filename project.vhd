library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity project is
	port(
		clk, reset: in std_logic;
		x,y : in std_logic_vector (6 downto 0);
		z   : out std_logic;
		q_occ,q_occ_max : out std_logic_vector (6 downto 0)--extra bit to consider for additions
);
	end project;

architecture behav of project is
signal q_occ_temp, q_occ_max_temp : std_logic_vector (6 downto 0);
signal z_temp	:	std_logic;


begin
	q_occ<=q_occ_temp;
	q_occ_max<=q_occ_max_temp;
	z<=z_temp;



	process (clk, reset)
	variable total, sum, sub, sum_temp, sub_temp:	unsigned (6 downto 0);
	begin


		if (reset='1') then
			q_occ_temp<="0000000";
			q_occ_max_temp<="0111111";
		elsif (clk'event and clk='1') then
		sum_temp:=(unsigned(q_occ_temp)+unsigned(x));
		sub_temp:=(unsigned(q_occ_temp)-unsigned(y));
			if (z_temp='1') then
			q_occ_temp<=q_occ_temp;
			elsif (z_temp='0') then
				if (std_logic_vector(sum_temp)<="0111111") then
				sum:=(unsigned(q_occ_temp)+unsigned(x));
				else
				sum:="0111111";
				end if;

			end if;

		if (unsigned(x)>unsigned(y) and std_logic_vector(sub_temp)>="0000000") then
			sub:=(unsigned(q_occ_temp)+unsigned(y));
			total:=sum-sub;
			q_occ_temp<=std_logic_vector(total+unsigned(q_occ_temp));
		
		elsif (unsigned(y)>unsigned(x) and std_logic_vector(sub_temp)>="0000000") then
			sub:=unsigned(q_occ_temp)+unsigned(y);
			total:=sub-sum;
			q_occ_temp<=std_logic_vector(unsigned(q_occ_temp)-total);
		elsif (unsigned(y)=unsigned(x)) then
			q_occ_temp<=q_occ_temp;
	  	else 
			sub:="0000000";
			total:=sum;
			q_occ_temp<=std_logic_vector(unsigned(q_occ_temp)+total);
	  	end if;


	end if;
	end process;

	process (q_occ_temp,q_occ_max_temp)
		begin
		if (q_occ_temp=q_occ_max_temp) then
		z_temp<='1';
		else
		z_temp<='0';
		end if;
	end process;

end behav;
