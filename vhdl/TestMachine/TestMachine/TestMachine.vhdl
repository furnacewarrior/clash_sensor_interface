-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.testmachine_types.all;

entity TestMachine is
  port(-- clock
       clk    : in std_logic;
       -- asynchronous reset: active high
       rst    : in std_logic;
       input  : in unsigned(7 downto 0);
       output : out unsigned(7 downto 0));
end;

architecture structural of TestMachine is
  signal s1             : testmachine_types.tup2;
  signal \#s1_case_alt\ : testmachine_types.tup2;
  signal \stateL\       : unsigned(2 downto 0);
begin
  output <= s1.tup2_sel0;

  -- register begin 
  testmachine_register : process(clk,rst)
  begin
    if rst = '1' then
      s1 <= ( tup2_sel0 => to_unsigned(0,8), tup2_sel1 => to_unsigned(0,3) )
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(clk) then
      s1 <= \#s1_case_alt\
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  with (\stateL\) select
    \#s1_case_alt\ <= ( tup2_sel0 => to_unsigned(9,8)
                      , tup2_sel1 => to_unsigned(1,3) ) when "000",
                      ( tup2_sel0 => to_unsigned(10,8)
                      , tup2_sel1 => to_unsigned(2,3) ) when "001",
                      ( tup2_sel0 => to_unsigned(11,8)
                      , tup2_sel1 => to_unsigned(3,3) ) when "010",
                      ( tup2_sel0 => to_unsigned(12,8)
                      , tup2_sel1 => to_unsigned(4,3) ) when "011",
                      ( tup2_sel0 => to_unsigned(8,8)
                      , tup2_sel1 => to_unsigned(0,3) ) when "100",
                      testmachine_types.tup2'( unsigned'(0 to 7 => '-'), unsigned'(0 to 2 => '-') ) when others;

  \stateL\ <= s1.tup2_sel1;
end;

