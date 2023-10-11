library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Alu_tb is
end entity;


architecture tb of Alu_tb is
    component Alu 
        port (
            op1     : in std_logic_vector(31 downto 0);
            op2     : in std_logic_vector(31 downto 0);
            cin     : in std_logic;
            cmd     : in std_logic_vector(1 downto 0);
            res     : out std_logic_vector(31 downto 0);
            cout    : out std_logic;
            z       : out std_logic;
            n       : out std_logic;
            v       : out std_logic;
            vdd     : in bit;
            vss     : in bit
        );
        end component;

        signal tb_cin           : std_logic;
        signal tb_op1           : std_logic_vector(31 downto 0);
        signal tb_op2           : std_logic_vector(31 downto 0);
        signal tb_result        : std_logic_vector(31 downto 0);
        signal tb_cout          : std_logic;
        signal tb_cmd           : std_logic_vector(1 downto 0);
        signal tb_z, tb_n, tb_v : std_logic;
        signal tb_vdd, tb_vss   : bit;

        begin
        
        Alu1 : Alu port map(tb_op1,tb_op2, 
            tb_cin, 
            tb_cmd, 
            tb_result, 
            tb_cout, 
            tb_z,tb_n, tb_v, 
            tb_vdd, tb_vss );

        process
            begin
                tb_cin<= '0';
                tb_op1 <= std_logic_vector(to_unsigned(23,32));
                tb_op2 <= std_logic_vector(to_unsigned(12,32));
                tb_cmd <= std_logic_vector(to_unsigned(0,2));
                tb_vdd <= '1';
                tb_vss <= '0';
            wait for 10 ns;
            wait;
            end process;
            
            

    end architecture;