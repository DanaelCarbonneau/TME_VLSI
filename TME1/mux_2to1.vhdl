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


