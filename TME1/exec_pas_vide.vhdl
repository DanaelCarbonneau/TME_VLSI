library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EXec is
	port(
	-- Decode interface synchro
			dec2exe_empty	: in Std_logic;
			exe_pop			: out Std_logic;

	-- Decode interface operands
			dec_op1			: in Std_Logic_Vector(31 downto 0); -- first alu input
			dec_op2			: in Std_Logic_Vector(31 downto 0); -- shifter input
			dec_exe_dest	: in Std_Logic_Vector(3 downto 0); -- Rd destination
			dec_exe_wb		: in Std_Logic; -- Rd destination write back
			dec_flag_wb		: in Std_Logic; -- CSPR modifiy

	-- Decode to mem interface 
			dec_mem_data	: in Std_Logic_Vector(31 downto 0); -- data to MEM W
			dec_mem_dest	: in Std_Logic_Vector(3 downto 0); -- Destination MEM R
			dec_pre_index 	: in Std_logic;

			dec_mem_lw		: in Std_Logic;
			dec_mem_lb		: in Std_Logic;
			dec_mem_sw		: in Std_Logic;
			dec_mem_sb		: in Std_Logic;

	-- Shifter command
			dec_shift_lsl	: in Std_Logic;
			dec_shift_lsr	: in Std_Logic;
			dec_shift_asr	: in Std_Logic;
			dec_shift_ror	: in Std_Logic;
			dec_shift_rrx	: in Std_Logic;
			dec_shift_val	: in Std_Logic_Vector(4 downto 0);
			dec_cy			: in Std_Logic;

	-- Alu operand selection
			dec_comp_op1	: in Std_Logic;
			dec_comp_op2	: in Std_Logic;
			dec_alu_cy 		: in Std_Logic;

	-- Alu command
			dec_alu_cmd		: in Std_Logic_Vector(1 downto 0);

	-- Exe bypass to decod
			exe_res			: out Std_Logic_Vector(31 downto 0);

			exe_c				: out Std_Logic;
			exe_v				: out Std_Logic;
			exe_n				: out Std_Logic;
			exe_z				: out Std_Logic;

			exe_dest			: out Std_Logic_Vector(3 downto 0); -- Rd destination
			exe_wb			: out Std_Logic; -- Rd destination write back
			exe_flag_wb		: out Std_Logic; -- CSPR modifiy

	-- Mem interface
			exe_mem_adr		: out Std_Logic_Vector(31 downto 0); -- Alu res register
			exe_mem_data	: out Std_Logic_Vector(31 downto 0);
			exe_mem_dest	: out Std_Logic_Vector(3 downto 0);

			exe_mem_lw		: out Std_Logic;
			exe_mem_lb		: out Std_Logic;
			exe_mem_sw		: out Std_Logic;
			exe_mem_sb		: out Std_Logic;

			exe2mem_empty	: out Std_logic;
			mem_pop			: in Std_logic;

	-- global interface
			ck					: in Std_logic;
			reset_n			: in Std_logic;
			vdd				: in bit;
			vss				: in bit);
end EXec;

----------------------------------------------------------------------

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_2to1 is
    port (
        a,b : in std_logic_vector(31 downto 0);
        s0   : in std_logic;
        z       : out std_logic_vector(31 downto 0)
    );
    end mux_2to1;
architecture mon_mux of mux_2to1 is
    begin
        process(a,b,s0) is
            begin
                if (s0 = '0' ) then
                    z<= a;
                elsif (s0 = '1') then
                    z<= b;
                end if;
            end process;
        end mon_mux;



architecture Behavior OF EXec is

signal shift_out : std_logic_vector (31 downto 0);


signal shift_out_not : std_logic_vector (31 downto 0);
signal op1_not : std_logic_vector (31 downto 0);


signal mux_out_shift : std_logic_vector (31 downto 0);
signal mux_out_op1 : std_logic_vector (31 downto 0);

signal exe_push : std_logic;
signal exe2mem_full : std_logic;
signal mem_adr : std_logic_vector (31 downto 0);

signal alu_out : std_logic_vector (31 downto 0);


component mux_2to1
	port (
		a,b : in std_logic_vector(31 downto 0);
		s0   : in std_logic;
		z       : out std_logic_vector(31 downto 0)
	);
end component;

component Shifter
	port(
		shift_lsl : in  Std_Logic;
		shift_lsr : in  Std_Logic;
		shift_asr : in  Std_Logic;
		shift_ror : in  Std_Logic;
		shift_rrx : in  Std_Logic;
		shift_val : in  Std_Logic_Vector(4 downto 0);
		din       : in  Std_Logic_Vector(31 downto 0);
		cin       : in  Std_Logic;
		dout      : out Std_Logic_Vector(31 downto 0);
		cout      : out Std_Logic;
		
		vdd       : in  bit;
		vss       : in  bit 
		
		);



end component;


component Alu
    port ( op1			: in Std_Logic_Vector(31 downto 0);
           op2			: in Std_Logic_Vector(31 downto 0);
           cin			: in Std_Logic;

           cmd			: in Std_Logic_Vector(1 downto 0);

           res			: out Std_Logic_Vector(31 downto 0);
           cout		: out Std_Logic;
           z			: out Std_Logic;
           n			: out Std_Logic;
           v			: out Std_Logic;
			  
			  vdd			: in bit;
			  vss			: in bit);
end component;

component fifo_72b
	port(
		din		: in std_logic_vector(71 downto 0);
		dout		: out std_logic_vector(71 downto 0);

		-- commands
		push		: in std_logic;
		pop		: in std_logic;

		-- flags
		full		: out std_logic;
		empty		: out std_logic;

		reset_n	: in std_logic;
		ck			: in std_logic;
		vdd		: in bit;
		vss		: in bit
	);
end component;


begin
--  Component instantiation.
	shift_out_not <= not shift_out;
	op1_not <= not dec_op1;

	mux_shift : mux_2to1
	port map(
			a => shift_out,
			b => shift_out_not,
			s0 => dec_comp_op2,
			z => mux_out_shift
	);

	mux_op1 : mux_2to1
	port map(
			a => dec_op1,
			b => op1_not,
			s0 => dec_comp_op1,
			z => mux_out_op1
	);


	shifter_inst : Shifter
	port map(
	shift_lsl => dec_shift_lsl	,
    shift_lsr => dec_shift_lsr 	,
    shift_asr => dec_shift_asr	,
    shift_ror => dec_shift_ror	,
    shift_rrx => dec_shift_rrx	,
    shift_val => dec_shift_val	,
    din       => dec_op2		,
    cin       => dec_cy			,
    dout      => shift_out		,
    cout      => exe_c			,
    -- global interface --
    vdd       => vdd			,
    vss       => vss	);


	alu_inst : alu
	port map (	
					op1 => mux_out_op1,
					op2 => mux_out_shift,
					cin => dec_alu_cy,
					cmd => dec_alu_cmd,
					res => alu_out,
					cout	=> exe_c,
					z	=> exe_z,
					n	=> exe_n,
					v	=> exe_v,
					vdd	=> vdd,
					vss	=> vss);

	mux_alu :mux_2to1
	port map(
			a => dec_op1,
			b => alu_out,
			s0 => dec_pre_index,
			z => mem_adr
	);
	exe_push <= '1' when (dec_mem_sb ='1' or dec_mem_sw='1') else '0';


	exec2mem : fifo_72b
	port map (	din(71)	 => dec_mem_lw,
					din(70)	 => dec_mem_lb,
					din(69)	 => dec_mem_sw,
					din(68)	 => dec_mem_sb,

					din(67 downto 64) => dec_mem_dest,
					din(63 downto 32) => dec_mem_data,
					din(31 downto 0)	 => mem_adr,

					dout(71)	 => exe_mem_lw,
					dout(70)	 => exe_mem_lb,
					dout(69)	 => exe_mem_sw,
					dout(68)	 => exe_mem_sb,

					dout(67 downto 64) => exe_mem_dest,
					dout(63 downto 32) => exe_mem_data,
					dout(31 downto 0)	 => exe_mem_adr,

					push		 => exe_push,
					pop		 => mem_pop,

					empty		 => exe2mem_empty,
					full		 => exe2mem_full,

					reset_n	 => reset_n,
					ck			 => ck,
					vdd		 => vdd,
					vss		 => vss);
	

end Behavior;
