library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg_tb is 
end Reg_tb;

architecture Behavior OF Reg_tb is

	component Reg is 
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

	end component;


-- Write Port 1 prioritaire
		signal tb_wdata1		: Std_Logic_Vector(31 downto 0);
		signal tb_wadr1			: Std_Logic_Vector(3 downto 0);
		signal tb_wen1			: Std_Logic;

	-- Write Port 2 non prioritaire
		signal tb_wdata2		:  Std_Logic_Vector(31 downto 0);
		signal tb_wadr2			:  Std_Logic_Vector(3 downto 0);
		signal tb_wen2			:  Std_Logic;

	-- Write CSPR Port
		signal tb_wcry			: Std_Logic;
		signal tb_wzero			: Std_Logic;
		signal tb_wneg			: Std_Logic;
		signal tb_wovr			: Std_Logic;
		signal tb_cspr_wb		    : Std_Logic;
		
	-- Read Port 1 32 bits
		signal tb_reg_rd1		: Std_Logic_Vector(31 downto 0);
		signal tb_radr1			: Std_Logic_Vector(3 downto 0);
		signal tb_reg_v1		:  Std_Logic;

	-- Read Port 2 32 bits
		signal tb_reg_rd2		: Std_Logic_Vector(31 downto 0);
		signal tb_radr2			: Std_Logic_Vector(3 downto 0);
		signal tb_reg_v2		: Std_Logic;

	-- Read Port 3 32 bits
		signal tb_reg_rd3		: Std_Logic_Vector(31 downto 0);
		signal tb_radr3			: Std_Logic_Vector(3 downto 0);
		signal tb_reg_v3		: Std_Logic;

	-- read CSPR Port
		signal tb_reg_cry		: Std_Logic;
		signal tb_reg_zero		: Std_Logic;
		signal tb_reg_neg		: Std_Logic;
		signal tb_reg_cznv		: Std_Logic;
		signal tb_reg_ovr		: Std_Logic;
		signal tb_reg_vv		: Std_Logic;
		
	-- Invalidate Port 
		signal tb_inval_adr1	:  Std_Logic_Vector(3 downto 0);
		signal tb_inval1		:  Std_Logic;

		signal tb_inval_adr2	:  Std_Logic_Vector(3 downto 0);
		signal tb_inval2		:  Std_Logic;

		signal tb_inval_czn	:  Std_Logic;
		signal tb_inval_ovr	:  Std_Logic;

	-- PC
		signal tb_reg_pc		: Std_Logic_Vector(31 downto 0);
		signal tb_reg_pcv		: Std_Logic;
		signal tb_inc_pc		: Std_Logic;
	
	-- global interface
		signal tb_ck			: Std_Logic;
		signal tb_reset_n		: Std_Logic;
		signal tb_vdd			: bit;
		signal tb_vss			: bit;

	begin

		tb_vdd <= '1';
		tb_vss <= '0';

		process
			begin
				tb_ck <= '0';
				wait for 1 ns;
				tb_ck <= '1';
				wait for 1 ns;
		end process;

		Reg1 : Reg port map(
			tb_wdata1,
			tb_wadr1,
			tb_wen1,
			tb_wdata2,
			tb_wadr2,
			tb_wen2,
			tb_wcry,
			tb_wzero,
			tb_wneg,
			tb_wovr,
			tb_cspr_wb,
			tb_reg_rd1,
			tb_radr1,
			tb_reg_v1,
			tb_reg_rd2,
			tb_radr2,
			tb_reg_v2,
			tb_reg_rd3,
			tb_radr3,
			tb_reg_v3,
			tb_reg_cry,
			tb_reg_zero,
			tb_reg_neg,
			tb_reg_cznv,
			tb_reg_ovr,
			tb_reg_vv,
			tb_inval_adr1,
			tb_inval1,
			tb_inval_adr2,
			tb_inval2,
			tb_inval_czn,
			tb_inval_ovr,
			tb_reg_pc,
			tb_reg_pcv,
			tb_inc_pc,
			tb_ck,
			tb_reset_n,
			tb_vdd,
			tb_vss
	);

	process
		begin
			tb_reset_n <= '0';
            wait for 10 ns;
			tb_wcry <= '1';
			tb_wzero <= '0';
			tb_wneg <= '0';
            tb_reset_n <= '1';

			tb_inc_pc <= '1';

			tb_inval_adr1 <= "0001";
			tb_inval1 <= '1';
			tb_inval_czn <= '1';
			tb_cspr_wb <= '1';
			
			tb_inval_adr2 <= "0011";
			tb_inval2 <= '1';

			wait for 10 ns;
			tb_inval_czn <= '0';
			tb_inval1 <= '0';
			tb_inval2 <= '0';
			


			tb_wdata1 <= std_logic_vector(to_unsigned(16,32));
			tb_wadr1 <= "0001";
			tb_wen1 <= '1';

			tb_wdata2 <= std_logic_vector(to_unsigned(1,32));
			tb_wadr2 <= "0011";
			tb_wen2 <= '1';

			wait for 10 ns;
			tb_inval_adr1 <= "0010";
			tb_inval1 <= '1';

			wait for 10 ns;
			tb_inval1 <= '0';

			tb_wdata1 <= std_logic_vector(to_unsigned(16,32));
			tb_wadr1 <= "0010";
			tb_wen1 <= '1';

			tb_wdata2 <= std_logic_vector(to_unsigned(1,32));
			tb_wadr2 <= "0010";
			tb_wen2 <= '1';

			wait for 10 ns;
			tb_inc_pc <= '0';
			tb_inval_adr1 <= "1111";
			tb_inval1 <= '1';
			
			wait for 10 ns;
		
			tb_inval1 <= '0';
			
			tb_wdata1 <= std_logic_vector(to_unsigned(16,32));
			tb_wadr1 <= "1111";
			tb_wen1 <= '1';
			tb_inc_pc <= '1';


			wait;
	end process;


end Behavior;
