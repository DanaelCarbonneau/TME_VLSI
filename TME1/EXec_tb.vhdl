library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Exec_tb is
end entity;


architecture tb of Exec_tb is
    component EXec 
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
        end component;

-- Déclaration des signaux temporaires
        -- Decode interface synchro
        signal t_dec2exe_empty  : Std_logic;
        signal t_exe_pop		    : Std_logic;
-- Decodsignal t_e interface oprands
        signal t_dec_op1    : Std_Logic_Vector(31 downto 0); -- first alu input
        signal t_dec_op2    : Std_Logic_Vector(31 downto 0); -- shifter input
        signal t_dec_exe_dest	: Std_Logic_Vector(3 downto 0); -- Rd destination
        signal t_dec_exe_wb		: Std_Logic; -- Rd destination write back
        signal t_dec_flag_wb    : Std_Logic; -- CSPR modifiy
-- Decodsignal t_e to mem interace 
        signal t_dec_mem_data	: Std_Logic_Vector(31 downto 0); -- data to MEM W
        signal t_dec_mem_dest	: Std_Logic_Vector(3 downto 0); -- Destination MEM R
        signal t_dec_pre_index  : Std_logic;
        signal t_dec_mem_lw		: Std_Logic;
        signal t_dec_mem_lb		: Std_Logic;
        signal t_dec_mem_sw		: Std_Logic;
        signal t_dec_mem_sb		: Std_Logic;
-- Shiftsignal t_er command:
        signal t_dec_shift_lsl	: Std_Logic;
        signal t_dec_shift_lsr	: Std_Logic;
        signal t_dec_shift_asr	: Std_Logic;
        signal t_dec_shift_ror	: Std_Logic;
        signal t_dec_shift_rrx	: Std_Logic;
        signal t_dec_shift_val	: Std_Logic_Vector(4 downto 0);
        signal t_dec_cy			: std_logic;

-- Alu osignal t_perand selectin
        signal t_dec_comp_op1	: Std_Logic;
        signal t_dec_comp_op2	: Std_Logic;
        signal t_dec_alu_cy 	: Std_Logic;
-- Alu csignal t_ommand
       signal t_dec_alu_cmd		: Std_Logic_Vector(1 downto 0);
-- Exe bypass to decod
        signal t_exe_res			:  Std_Logic_Vector(31 downto 0);       
        signal t_exe_c				: Std_Logic;
        signal t_exe_v				:  Std_Logic;
        signal t_exe_n				: Std_Logic;
        signal t_exe_z				: Std_Logic;
        signal t_exe_dest			: Std_Logic_Vector(3 downto 0); -- Rd destination
        signal t_exe_wb			: Std_Logic; -- Rd destination write back
        signal t_exe_flag_wb		: Std_Logic; -- CSPR modifiy

       -- Mem isignal t_nterface
       signal t_exe_mem_adr		:  Std_Logic_Vector(31 downto 0); -- Alu res register
       signal t_exe_mem_data	: Std_Logic_Vector(31 downto 0);
       signal t_exe_mem_dest	: Std_Logic_Vector(3 downto 0);
       signal t_exe_mem_lw		: Std_Logic;
       signal t_exe_mem_lb		: Std_Logic;
       signal t_exe_mem_sw		: Std_Logic;
       signal t_exe_mem_sb		: Std_Logic;
       signal t_exe2mem_empty	    : Std_logic;
       signal t_mem_pop			: Std_logic;

-- globasignal t_l interface
       signal t_ck				:  Std_logic;
        signal t_reset_n		: Std_logic;
        signal t_vdd			: bit;
        signal t_vss			: bit;

       


        begin

            EXec1 : EXec port map (
                t_dec2exe_empty,
                t_exe_pop	,
        -- Decodsignal t_e interface oprands
             t_dec_op1    ,
             t_dec_op2    ,  
             t_dec_exe_dest,
             t_dec_exe_wb,		
             t_dec_flag_wb, 
        -- Deco t_e to mem interace 
             t_dec_mem_data,
             t_dec_mem_dest, 
             t_dec_pre_index ,
             t_dec_mem_lw	,
             t_dec_mem_lb	,
             t_dec_mem_sw	,
             t_dec_mem_sb	,
        -- Shif t_er command:
            t_dec_shift_lsl,
             t_dec_shift_lsr,
             t_dec_shift_asr,
             t_dec_shift_ror,
             t_dec_shift_rrx,
             t_dec_shift_val,
             t_dec_cy,
       -- Alu osignal t_perand selectin
             t_dec_comp_op1	,
             t_dec_comp_op2	,
             t_dec_alu_cy 	,
        -- Alu  t_ommand
            t_dec_alu_cmd,		
        -- Exe bypass to decod
            t_exe_res			,       
            t_exe_c				, 
            t_exe_v				, 
            t_exe_n				, 
            t_exe_z				, 
            t_exe_dest			,
            t_exe_wb			, 
            t_exe_flag_wb,        
               -- Mem isignal t_nterface
            t_exe_mem_adr,		
            t_exe_mem_data,	
            t_exe_mem_dest,	
            t_exe_mem_lw,		
            t_exe_mem_lb,		
            t_exe_mem_sw,		
            t_exe_mem_sb,		
            t_exe2mem_empty,
            t_mem_pop,     
        -- globasignal t_l interface
            t_ck,			
            t_reset_n,		
            '1',			
            '0'			
            );


        process
                begin
                        t_ck <= '0';
                        wait for 1 ns;
                        t_ck <= '1';
                        wait for 1 ns;
        end process;
            process
            begin

                t_reset_n <= '0';
                wait for 10 ns;
                t_reset_n <= '1';
                t_dec2exe_empty <= '0';
                
                t_dec_op1 <= std_logic_vector(to_unsigned(0,32));
                t_dec_op2 <= std_logic_vector(to_unsigned(0,32));
                t_dec_exe_dest <= std_logic_vector(to_unsigned(0,4));
                t_dec_exe_wb <= '0';
                t_dec_flag_wb <= '0';

                t_dec_pre_index <= '0';
                t_dec_mem_lw <= '0';
                t_dec_mem_lb <= '0';
                t_dec_mem_sw <= '0';
                t_dec_mem_sb <= '0';

                t_dec_shift_lsl <= '0';
                t_dec_shift_lsr <= '0';
                t_dec_shift_asr <= '0';
                t_dec_shift_ror <= '0';
                t_dec_shift_rrx <= '0';
                t_dec_shift_val <= std_logic_vector(to_unsigned(0,5));
                t_dec_cy <= '0';


                t_dec_comp_op1 <= '0';
                t_dec_comp_op2 <= '0';
                t_dec_alu_cy <= '0';

                t_dec_alu_cmd <= std_logic_vector(to_unsigned(0,2));

                t_mem_pop <= '0';

              
                t_dec_mem_data <= std_logic_vector(to_unsigned(0,32));
                t_dec_mem_dest <= std_logic_vector(to_unsigned(0,4));


                wait for 10 ns;

                t_dec_alu_cmd <= std_logic_vector(to_unsigned(0,2));
                t_dec_comp_op1 <= '1';
                t_dec_comp_op2 <= '0';
                
                
                t_dec_mem_sw <= '1';
                
                t_dec_mem_data <= X"FFFF0000";
               

                t_dec_op1 <= std_logic_vector(to_unsigned(10,32));
                t_dec_op2 <= std_logic_vector(to_unsigned(13,32));
                t_dec_alu_cmd <= std_logic_vector(to_unsigned(0,2));

                wait for 10 ns;
                t_dec2exe_empty <= '1';

                t_mem_pop <= '1';

                wait for 10 ns;


                t_mem_pop <= '0';
            
            wait;
            end process;
        end tb;
            
