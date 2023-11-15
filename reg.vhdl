library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg is
	port(
	-- Write Port 1 prioritaire
		wdata1		: in Std_Logic_Vector(31 downto 0);
		wadr1			: in Std_Logic_Vector(3 downto 0);
		wen1			: in Std_Logic;

	-- Write Port 2 non prioritaire
		wdata2		: in Std_Logic_Vector(31 downto 0);
		wadr2			: in Std_Logic_Vector(3 downto 0);
		wen2			: in Std_Logic;

	-- Write CSPR Port
		wcry			: in Std_Logic;
		wzero			: in Std_Logic;
		wneg			: in Std_Logic;
		wovr			: in Std_Logic;
		cspr_wb		: in Std_Logic;
		
	-- Read Port 1 32 bits
		reg_rd1		: out Std_Logic_Vector(31 downto 0);
		radr1			: in Std_Logic_Vector(3 downto 0);
		reg_v1		: out Std_Logic;

	-- Read Port 2 32 bits
		reg_rd2		: out Std_Logic_Vector(31 downto 0);
		radr2			: in Std_Logic_Vector(3 downto 0);
		reg_v2		: out Std_Logic;

	-- Read Port 3 32 bits
		reg_rd3		: out Std_Logic_Vector(31 downto 0);
		radr3			: in Std_Logic_Vector(3 downto 0);
		reg_v3		: out Std_Logic;

	-- read CSPR Port
		reg_cry		: out Std_Logic;
		reg_zero		: out Std_Logic;
		reg_neg		: out Std_Logic;
		reg_cznv		: out Std_Logic;
		reg_ovr		: out Std_Logic;
		reg_vv		: out Std_Logic;
		
	-- Invalidate Port 
		inval_adr1	: in Std_Logic_Vector(3 downto 0);
		inval1		: in Std_Logic;

		inval_adr2	: in Std_Logic_Vector(3 downto 0);
		inval2		: in Std_Logic;

		inval_czn	: in Std_Logic;
		inval_ovr	: in Std_Logic;

	-- PC
		reg_pc		: out Std_Logic_Vector(31 downto 0);
		reg_pcv		: out Std_Logic;
		inc_pc		: in Std_Logic;
	
	-- global interface
		ck				: in Std_Logic;
		reset_n		: in Std_Logic;
		vdd			: in bit;
		vss			: in bit);
end Reg;


LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registre_32b is
    port (
        D : in std_logic_vector(31 downto 0);
        ck,reset_n   : in std_logic;
        Q       : out std_logic_vector(31 downto 0)
    );
    end registre_32b;
architecture mon_registre of registre_32b is
    begin
        process(ck, reset_n) is
            begin
                if (reset_n ='0' ) then
                    Q<= (others => '0');
                elsif rising_edge(ck) then
                    Q<= D;
                end if;
            end process;
     end mon_registre;

architecture Behavior OF Reg is


component registre_32b
	port(
		D : in std_logic_vector(31 downto 0);
	        ck,reset_n   : in std_logic;
        	Q       : out std_logic_vector(31 downto 0)
	);
end component;

--bitmamp de validité des registres --
signal valid_r_bitmap 	: std_logic_vector (15 downto 0);

--signaux d'entrée des registres
signal d0 				: std_logic_vector (31 downto 0);
signal d1 				: std_logic_vector (31 downto 0);
signal d2 				: std_logic_vector (31 downto 0);
signal d3 				: std_logic_vector (31 downto 0);
signal d4 				: std_logic_vector (31 downto 0);
signal d5 				: std_logic_vector (31 downto 0);
signal d6 				: std_logic_vector (31 downto 0);
signal d7 				: std_logic_vector (31 downto 0);
signal d8 				: std_logic_vector (31 downto 0);
signal d9 				: std_logic_vector (31 downto 0);
signal d10 				: std_logic_vector (31 downto 0);
signal d11 				: std_logic_vector (31 downto 0);
signal d12 				: std_logic_vector (31 downto 0);
signal d_sp				: std_logic_vector (31 downto 0);
signal d_lr				: std_logic_vector (31 downto 0);
signal d_pc				: std_logic_vector (31 downto 0);

-- registre CSPR bit 0 : C, bit 1 : Z, bit 2 : N, bit 3 : V, bit 4 : validité de CZN, bit 5 : validité de V
signal cspr 			: std_logic_vector (5 downto 0);


--signaux de sortie des registres
signal q0 				: std_logic_vector (31 downto 0);
signal q1 				: std_logic_vector (31 downto 0);
signal q2 				: std_logic_vector (31 downto 0);
signal q3 				: std_logic_vector (31 downto 0);
signal q4 				: std_logic_vector (31 downto 0);
signal q5 				: std_logic_vector (31 downto 0);
signal q6 				: std_logic_vector (31 downto 0);
signal q7 				: std_logic_vector (31 downto 0);
signal q8 				: std_logic_vector (31 downto 0);
signal q9 				: std_logic_vector (31 downto 0);
signal q10 				: std_logic_vector (31 downto 0);
signal q11 				: std_logic_vector (31 downto 0);
signal q12 				: std_logic_vector (31 downto 0);
signal q_sp				: std_logic_vector (31 downto 0);
signal q_lr				: std_logic_vector (31 downto 0);
signal q_pc				: std_logic_vector (31 downto 0);





begin
--Components inctanciation--

	--reset de la bitmap (0 pour invalide par défaut)--
	process(reset_n) is
        begin
            if (reset_n ='0' ) then
                valid_r_bitmap 		<= (others => '1');
				cspr (3 downto 0)	<= (others => '0');
				cspr (5 downto 4)	<= (others => '1');
            end if;
        end process;

	--Tous les 16 registres--
	registre_0 : registre_32b
		port map(
			
			D=>	d0,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q0

	);

	registre_1 : registre_32b
		port map(
			
			D=>	d1,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q1

	);

	registre_2 : registre_32b
		port map(
			
			D=>	d2,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q2

	);

	registre_3 : registre_32b
		port map(
			
			D=>	d3,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q3

	);

	registre_4 : registre_32b
		port map(
			
			D=>	d4,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q4	

	);

	registre_5 : registre_32b
		port map(
			
			D=>	d5,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q5	

	);

	registre_6 : registre_32b
		port map(
			
			D=>	d6,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q6

	);

	registre_7 : registre_32b
		port map(
			
			D=>	d7,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q7	

	);

	registre_8 : registre_32b
		port map(
			
			D=>	d8,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q8	

	);

	registre_9 : registre_32b
		port map(
			
			D=>	d9,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q9	

	);

	registre_10 : registre_32b
		port map(
			
			D=>d10	,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q10	

	);

	registre_11 : registre_32b
		port map(
			
			D=>	d11,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q11	

	);

	registre_12 : registre_32b
		port map(
			
			D=>	d12,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q12	

	);

	registre_SP : registre_32b
		port map(
			
			D=>	d_sp,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q_sp	

	);

	registre_LR : registre_32b
		port map(
			
			D=>	d_lr,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q_lr	

	);

	registre_PC : registre_32b
		port map(
			
			D=>	d_pc,
			ck=>ck	,
			reset_n=> reset_n,
			Q=>	q_pc	

	);

	


	-- Ecriture dans CSPR --
	process(ck) is
		begin
			if rising_edge(ck) then
				if (cspr_wb = '1') then 
					if (cspr(4) = '0') then 
						cspr(0) <= wcry;
						cspr(1) <= wzero;
						cspr(2) <= wneg;
						cspr(4) <= '1';
					end if;
					if (cspr(5) = '0') then 
						cspr(3) <= wovr;
						cspr(5)	<= '1';
					end if;
				end if;
			end if;
		end process;

	-- Lecture dans CSPR --
	process(ck) is
		begin
			if rising_edge(ck) then
				reg_cry <= cspr(0);
				reg_zero<= cspr(1);
				reg_neg	<= cspr(2);
				reg_ovr	<= cspr(3);

				reg_cznv<= cspr(4);
				reg_vv	<= cspr(5);

			end if;
		end process;

	-- Invalidation des ports --

	valid_r_bitmap (to_integer (unsigned(inval_adr1))) 	<= '1' when inval1 = '1';
	valid_r_bitmap (to_integer (unsigned(inval_adr2))) 	<= '1' when inval2 = '1';
	cspr(4)												<= '1' when inval_czn = '1';
	cspr(5)												<= '1' when inval_ovr = '1';

	


	--increment du pc quand on a le signal inc_pc--
	d_pc <= std_logic_vector(to_unsigned ((to_integer(unsigned(q_pc)) + 4),32)) when inc_pc = '1';
	
	-- lien banc de registre / ports --
	reg_pcv <= valid_r_bitmap(15);
	reg_pc <= q_pc;

	-- aiguillage d'écriture --

	d0 <= 	wdata1 when (((wen1 = '1') and (wadr1 = X"0")) and (valid_r_bitmap (to_integer(unsigned(wadr1))) = '0')) else 
			wdata2 when (((wen2 = '1') and (wadr2 = X"0")) and (valid_r_bitmap (to_integer(unsigned(wadr2))) = '0')) else
			q0 when others;			
			
	d1 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"1")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1') and (wadr2 = X"1")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q1 when others;	
	d2 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"2")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"2")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q2;
	d3 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"3")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"3")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q3;
	d4 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"4")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"4")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q4;
	d5 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"5")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"5")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q5;
	d6 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"6")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"6")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q0;
	d7 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"7")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"7")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q7;
	d8 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"8")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"8")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q8;
	d9 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"9")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"9")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q9;
	d10 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"A")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"A")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q10;
	d11 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"B")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"B")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q11;
	d12 <= 	wdata1 when (((wen1 = '1'')  and (wadr1 = X"C")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"C")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q12;
	d_sp <= wdata1 when (((wen1 = '1'')  and (wadr1 = X"D")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"D")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q_sp;
	d_lr <= wdata1 when (((wen1 = '1'')  and (wadr1 = X"E")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"E")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q_lr;
	d_pc <= wdata1 when (((wen1 = '1'')  and (wadr1 = X"F")) and valid_r_bitmap (to_integer(unsigned(wadr1))) = '0') else 
			wdata2 when (((wen2 = '1')  and (wadr2 = X"F")) and valid_r_bitmap (to_integer(unsigned(wadr2))) = '0') else
			q_pc;

	-- En cas d'écriture, on valide le registre dans la bitmap --
	valid_r_bitmap(to_integer(unsigned(wadr1))) <= '1';
	valid_r_bitmap(to_integer(unsigned(wadr2))) <= '1';


	-- lecture --

	reg_rd1 <= 	q0 		when (radr1 = X"0") else
			   	q1 		when (radr1 = X"1") else
			   	q2 		when (radr1 = X"2") else
			   	q3 		when (radr1 = X"3") else
			   	q4 		when (radr1 = X"4") else
			   	q5 		when (radr1 = X"5") else
			   	q6 		when (radr1 = X"6") else
			   	q7 		when (radr1 = X"7") else
			   	q8 		when (radr1 = X"8") else
			   	q9 		when (radr1 = X"9") else
			   	q10 	when (radr1 = X"A") else
			   	q11 	when (radr1 = X"B") else
			   	q12 	when (radr1 = X"C") else
			   	q_sp 	when (radr1 = X"D") else
			   	q_lr 	when (radr1 = X"E") else
			   	q_pc 	when (radr1 = X"F");
	reg_v1 <= 	valid_r_bitmap (to_integer (unsigned(radr1)));

	reg_rd2 <= 	q0 		when (radr2 = X"0") else
			   	q1 		when (radr2 = X"1") else
			   	q2 		when (radr2 = X"2") else
			   	q3 		when (radr2 = X"3") else
			   	q4 		when (radr2 = X"4") else
			   	q5 		when (radr2 = X"5") else
			   	q6 		when (radr2 = X"6") else
			   	q7 		when (radr2 = X"7") else
			   	q8 		when (radr2 = X"8") else
			   	q9 		when (radr2 = X"9") else
			   	q10 	when (radr2 = X"A") else
			   	q11 	when (radr2 = X"B") else
			   	q12 	when (radr2 = X"C") else
			   	q_sp 	when (radr2 = X"D") else
			   	q_lr 	when (radr2 = X"E") else
			   	q_pc 	when (radr2 = X"F");
	reg_v2 <= 	valid_r_bitmap (to_integer (unsigned(radr2)));
	
	reg_rd3 <= 	q0 		when (radr3 = X"0") else
			   	q1 		when (radr3 = X"1") else
			   	q2 		when (radr3 = X"2") else
			   	q3 		when (radr3 = X"3") else
			   	q4 		when (radr3 = X"4") else
			   	q5 		when (radr3 = X"5") else
			   	q6 		when (radr3 = X"6") else
			   	q7 		when (radr3 = X"7") else
			   	q8 		when (radr3 = X"8") else
			   	q9 		when (radr3 = X"9") else
			   	q10 	when (radr3 = X"A") else
			   	q11 	when (radr3 = X"B") else
			   	q12 	when (radr3 = X"C") else
			   	q_sp 	when (radr3 = X"D") else
			   	q_lr 	when (radr3 = X"E") else
			   	q_pc 	when (radr3 = X"F");
	reg_v3 <= 	valid_r_bitmap (to_integer (unsigned(radr3)));



	










end Behavior;
