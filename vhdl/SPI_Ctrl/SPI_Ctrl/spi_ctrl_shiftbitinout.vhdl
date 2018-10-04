-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.spi_ctrl_types.all;

entity spi_ctrl_shiftbitinout is
  port(eta    : in std_logic_vector(7 downto 0);
       eta1   : in std_logic;
       result : out spi_ctrl_types.tup2_1);
end;

architecture structural of spi_ctrl_shiftbitinout is
  signal \#app_arg\ : std_logic_vector(7 downto 0);
begin
  -- replaceBit begin
  replacebit : block
    signal vec_index : integer range 0 to 8-1;
  begin
    vec_index <= to_integer(to_signed(0,64))
    -- pragma translate_off
                 mod 8
    -- pragma translate_on
                 ;

    process(vec_index,eta1)
      variable ivec : std_logic_vector(7 downto 0);
    begin
      ivec := (std_logic_vector(shift_left(unsigned(eta),to_integer(to_signed(1,64)))));
      ivec(vec_index) := eta1;
      \#app_arg\ <= ivec;
    end process;
  end block;
  -- replaceBit end

  result <= ( tup2_1_sel0 => \#app_arg\
            , tup2_1_sel1 =>  eta(eta'high)  );
end;

