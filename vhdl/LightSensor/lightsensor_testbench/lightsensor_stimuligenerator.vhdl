-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_testbench_types.all;

entity lightsensor_stimuligenerator is
  port(-- clock
       clk    : in std_logic;
       -- asynchronous reset: active high
       rst    : in std_logic;
       result : out std_logic);
end;

architecture structural of lightsensor_stimuligenerator is
  signal \#tup_app_arg\               : unsigned(4 downto 0);
  signal s                            : unsigned(4 downto 0);
  signal wild                         : signed(63 downto 0);
  signal \#tup_app_arg_selection_res\ : boolean;
  signal \#vec\                       : lightsensor_testbench_types.array_of_std_logic(0 to 29);
begin
  \#tup_app_arg_selection_res\ <= s < to_unsigned(29,5);

  \#tup_app_arg\ <= s + to_unsigned(1,5) when \#tup_app_arg_selection_res\ else
                    s;

  \#vec\ <= lightsensor_testbench_types.array_of_std_logic'( '0'
                                                           , '0'
                                                           , '1'
                                                           , '1'
                                                           , '0'
                                                           , '0'
                                                           , '1'
                                                           , '1'
                                                           , '0'
                                                           , '0'
                                                           , '1'
                                                           , '0'
                                                           , '1'
                                                           , '0'
                                                           , '0'
                                                           , '1'
                                                           , '1'
                                                           , '0'
                                                           , '0'
                                                           , '1'
                                                           , '0'
                                                           , '1'
                                                           , '0'
                                                           , '0'
                                                           , '1'
                                                           , '1'
                                                           , '0'
                                                           , '0'
                                                           , '1'
                                                           , '0' );

  -- index begin
  indexvec : block
    signal vec_index : integer range 0 to 30-1;
  begin
    vec_index <= to_integer((wild))
    -- pragma translate_off
                 mod 30
    -- pragma translate_on
                 ;
    result <= \#vec\(vec_index);
  end block;
  -- index end

  -- register begin 
  lightsensor_stimuligenerator_register : process(clk,rst)
  begin
    if rst = '1' then
      s <= to_unsigned(0,5)
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(clk) then
      s <= \#tup_app_arg\
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  wild <= (signed(std_logic_vector(resize(s,64))));
end;

