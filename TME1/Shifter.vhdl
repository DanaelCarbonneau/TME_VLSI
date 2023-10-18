LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity Shifter is
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
      -- global interface
      vdd       : in  bit;
      vss       : in  bit );
  end Shifter;

architecture mon_shifter of Shifter is

    begin process(shift_asr, shift_lsl, shift_asr, shift_ror, shift_rrx, shift_val, din,cin)
        variable shift_amount : integer := 0;
        begin
            shift_amount := to_integer(unsigned(shift_val));
        if (shift_lsl = '1') then
            -- shift left avec des unsigned --
            cout <= din(32 - shift_amount);
            dout <= std_logic_vector(shift_left(unsigned(din),shift_amount));
        elsif (shift_lsr = '1') then
            -- shift logique droite --
            cout <= din(shift_amount-1);
            dout <= std_logic_vector(shift_right(unsigned(din),shift_amount));
        elsif (shift_asr = '1') then 
            -- shift arithmétique droite --
            cout <= din(shift_amount-1);
            dout <= std_logic_vector(shift_right(signed(din),shift_amount));
        elsif (shift_ror = '1') then 
            -- rotation droite --
            cout <= din (shift_amount -1);
            dout <= din(shift_amount-1 downto 0) & din(31 downto shift_amount);
        elsif (shift_rrx = '1') then
            -- shift rrx--
            cout <= din(0);
            dout(31 downto 0) <=cin & din (31 downto 1);       --On met cin dans dout(31) et dout(31 downto 1) dans dout(30 downto 0)
        end if;
    end process;
end mon_shifter;
    
    