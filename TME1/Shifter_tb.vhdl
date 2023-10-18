library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Shifter_tb is
end entity;


architecture tb of Shifter_tb is
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
            -- global interface --
            vdd       : in  bit;
            vss       : in  bit );
        end component;

        signal t_shift_lsl : Std_Logic;
        signal t_shift_lsr : Std_Logic;
        signal t_shift_asr : Std_Logic;
        signal t_shift_ror : Std_Logic;
        signal t_shift_rrx : Std_Logic;
        signal t_shift_val : Std_Logic_Vector(4 downto 0);
        signal t_din       : Std_Logic_Vector(31 downto 0);
        signal t_cin       : Std_Logic;
        signal t_dout      : Std_Logic_Vector(31 downto 0);
        signal t_cout      : Std_Logic;


        begin
        
        Shifter1 : Shifter port map(
            t_shift_lsl,
            t_shift_lsr,
            t_shift_asr,
            t_shift_ror,
            t_shift_rrx,
            t_shift_val,
            t_din,
            t_cin,
            t_dout,
            t_cout,
            -- global interface --
            '1',
            '0');

        process
            begin
                t_shift_lsl <= '1';
                t_shift_lsr <= '0';
                t_shift_asr <= '0';
                t_shift_ror <= '0';
                t_shift_rrx <= '0';
                t_shift_val <= std_logic_vector(to_unsigned(30,5));
                t_din       <= std_logic_vector(to_unsigned(13,32));
                t_cin       <= '0';
            wait for 10 ns;
            t_shift_lsl <= '0';
                t_shift_lsr <= '1';
                t_shift_asr <= '0';
                t_shift_ror <= '0';
                t_shift_rrx <= '0';
                t_shift_val <= std_logic_vector(to_unsigned(10,5));
                t_din       <= std_logic_vector(to_unsigned(12,32));
                t_cin       <= '0';
            wait for 10 ns;
                t_shift_lsl <= '0';
                t_shift_lsr <= '0';
                t_shift_asr <= '1';
                t_shift_ror <= '0';
                t_shift_rrx <= '0';
                t_shift_val <= std_logic_vector(to_unsigned(10,5));
                t_din       <= std_logic_vector(to_unsigned(12,32));
                t_cin       <= '0';
            wait for 10 ns;
                t_shift_lsl <= '0';
                t_shift_lsr <= '0';
                t_shift_asr <= '0';
                t_shift_ror <= '1';
                t_shift_rrx <= '0';
                t_shift_val <=  std_logic_vector(to_unsigned(10,5));
                t_din       <= std_logic_vector(to_unsigned(12,32));
                t_cin       <= '0';
            wait for 10 ns;
                t_shift_lsl <= '0';
                t_shift_lsr <= '0';
                t_shift_asr <= '0';
                t_shift_ror <= '0';
                t_shift_rrx <= '1';
                t_shift_val <=  std_logic_vector(to_unsigned(10,5));
                t_din       <= std_logic_vector(to_unsigned(13,32));
                t_cin       <= '0';
            wait for 10 ns;
                t_cin       <= '1';
            wait for 10 ns;
                
            wait;
            end process;
            
            

    end architecture;