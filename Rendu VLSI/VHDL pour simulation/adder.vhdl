LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


ENTITY fulladd is
    PORT(
        a, b, cin : IN std_logic;
        r, cout : OUT std_logic);
end ENTITY;

ARCHITECTURE mon_fulladd of fulladd is
    BEGIN
    r <= (a xor b) xor cin;
    cout <= ((a xor b) and cin ) or (a and b);
END mon_fulladd;

LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


ENTITY add4bit is
    PORT(
        x : IN std_logic_vector(3 downto 0);
        y : IN std_logic_vector (3 downto 0);
        cin : IN std_logic;
        cout : OUT std_logic;
        r : OUT std_logic_vector (3 downto 0)
    );

end entity;

architecture mon_add4bit of add4bit is

    component fulladd is
        port (
            signal a : in std_logic;
            signal b : in std_logic;
            signal cin : in std_logic;
            signal r : out std_logic;
            signal cout : out std_logic
            );
    END component;
    signal c1,c2,c3 : std_logic;
    
    begin

    fa0 : component fulladd 
        port map (
            a => x(0),
            b => y(0),
            cin => cin,
            r => r(0),
            cout => c1
        );

    fa1 : component fulladd 
        port map (
            a => x(1),
            b => y(1),
            cin => c1,
            r => r(1),
            cout => c2
        );
    fa2 : component fulladd 
        port map (
            a => x(2),
            b => y(2),
            cin => c2,
            r => r(2),
            cout => c3
        );
    fa3 : component fulladd 
        port map (
            a => x(3),
            b => y(3),
            cin => c3,
            r => r(3),
            cout => cout
        );

end architecture;