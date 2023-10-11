library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb is
end entity;

architecture tb of adder_tb is
component add4bit
  port(
    x : IN std_logic_vector(3 downto 0);
    y : IN std_logic_vector (3 downto 0);
    cin : IN std_logic;
    cout : OUT std_logic;
    r : OUT std_logic_vector (3 downto 0)
);
end component;

signal tb_cin : std_logic;
signal tb_argument_x: std_logic_vector(3 downto 0);
signal tb_argument_y : std_logic_vector(3 downto 0);
signal tb_result: std_logic_vector(3 downto 0);
signal tb_cout : std_logic;
begin

U1: add4bit port map(tb_argument_x,tb_argument_y,tb_cin,tb_cout,tb_result);

process


begin
    tb_cin<='0';
    for i in 0 to 15 loop
        for j in 0 to 15 loop
            tb_argument_x <= std_logic_vector(to_unsigned(i,4));
            tb_argument_y <= std_logic_vector(to_unsigned(j,4));
            

            wait for 2 ns;

        end loop;
    end loop;

    -- Start computation
  tb_argument_x <= "1111";
  tb_argument_y <= "0000";
  tb_cin <= '0';

  wait for 10 ns;

  tb_argument_x <= "1010";
  tb_argument_y <= "0101";
  tb_cin <= '0';


  wait for 10 ns;

  tb_argument_x <= "1001";
  tb_argument_y <= "0011";
  tb_cin <= '0';

  wait for 10 ns;

  wait;
end process;

end architecture;


