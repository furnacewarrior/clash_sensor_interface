-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.clashtest_types.all;

entity clashtest_topentity is
  port(-- clock
       clk   : in std_logic;
       -- asynchronous reset: active high
       rst   : in std_logic;
       a     : in unsigned(7 downto 0);
       b     : in unsigned(7 downto 0);
       state : out unsigned(7 downto 0));
end;

architecture structural of clashtest_topentity is
  signal \#tup_case_alt\ : unsigned(7 downto 0);
begin
  \#tup_case_alt\ <= resize(a * b, 8);

  -- register begin 
  clashtest_topentity_register : process(clk,rst)
  begin
    if rst = '1' then
      state <= to_unsigned(0,8)
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(clk) then
      state <= \#tup_case_alt\
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end
end;

