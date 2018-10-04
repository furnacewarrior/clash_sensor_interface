-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.test_types.all;

entity Test is
  port(-- clock
       clk : in std_logic;
       -- asynchronous reset: active high
       rst : in std_logic;
       in  : in test_types.connstd;
       out : out std_logic_vector(7 downto 0));
end;

architecture structural of Test is
  signal s1  : test_types.connstd;
  signal ds1 : std_logic_vector(7 downto 0);
  signal ds2 : std_logic;
  signal ds3 : std_logic;
begin
  out <= s1.connstd_sel0;

  -- register begin 
  test_register : process(clk,rst)
  begin
    if rst = '1' then
      s1 <= ( connstd_sel0 => std_logic_vector'(x"00"), connstd_sel1 => '0', connstd_sel2 => '0' )
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(clk) then
      s1 <= ( connstd_sel0 => ds1, connstd_sel1 => ds2, connstd_sel2 => ds3 )
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  ds1 <= in.connstd_sel0;

  ds2 <= s1.connstd_sel1;

  ds3 <= s1.connstd_sel2;
end;

