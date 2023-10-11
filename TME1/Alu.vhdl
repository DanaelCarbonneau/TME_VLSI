LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_4to1 is
    port (
        a,b,c,d : in std_logic_vector(31 downto 0);
        s0,s1   : in std_logic;
        z       : out std_logic_vector(31 downto 0)
    );
    end mux_4to1;
architecture mon_mux of mux_4to1 is
    begin
        process(a,b,c,d,s0,s1) is
            begin
                if (s0 = '0' and s1 = '0') then
                    z<= a;
                elsif (s0 = '1' and s1 = '0') then
                    z<= b;
                elsif(s0 = '0' and s1 = '1') then
                    z<= c;
                else 
                    z <= d;
                end if;
            end process;
        end mon_mux;


LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Alu is 
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
    end Alu;
architecture mon_alu of Alu is 
    component mux_4to1 
        port (
            a,b,c,d     : in std_logic_vector(31 downto 0);
            s0,s1       : in std_logic;
            z           : out std_logic_vector(31 downto 0)
        );
        end component;
    signal radd, resor, rand, rxor, rmux : std_logic_vector(31 downto 0);
    
    begin
    radd <= std_logic_vector( unsigned(op1)+ unsigned(op2));
    resor <= op1 or op2;
    rand <= op1 and op2;
    rxor <= op1 xor op2;
-- 00 -> Add        (cmd = 0)
-- 10 -> or         (cmd = 2)
-- 01 -> and        (cmd = 1)
-- 11 -> xor        (cmd = 3)
    mux : component mux_4to1
        port map (
            a=> radd,
            b=> resor,
            c=> rand,
            d=> rxor,
            s0=> cmd(0),
            s1 => cmd(1),
            z => rmux
        );
    res <= rmux;
    -- Gestion des flags
    -- Retenue (cout) : 
    -- Si on fait une addition,
    -- cas 1 : les deux opérandes ont un bit de poids fort à 1, 
    -- cas 2 : l'un des deux a un bit de poids fort à 1 et le résultat a un bit de poids fort à 0.
    cout <= (( not cmd(0) and not cmd(1) )  and ((op1(31)and op2(31)) or (not radd(31) and (op1(31) or op2(31)))));

    -- Overflow relatifs (v) :
    -- Si on fait une addition,
    -- cas 1 : on additionne deux entiers négatifs, le résultat est positif
    -- cas 2 : on additionne deux entiers positifs, le résultat est négatif
    v <= ( not cmd(0) and not cmd(1) ) and ((not op1(31) and not op2(31) and radd(31)) or ((op1(31) and op2(31) and not radd(31))));
    
    -- Négatif (n):
    -- Si on fait une addition,
    -- Bit de poids fort du résultat
    n <= ( not cmd(0) and not cmd(1) ) and (radd(31));

    -- Nul (z) :
    -- Pour toutes les opérations,
    -- On compare le résultat du multiplexeur avec 0.

    z <= '1' when rmux = "0" else '0';


end mon_alu;