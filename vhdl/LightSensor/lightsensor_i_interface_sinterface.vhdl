-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_types.all;

entity lightsensor_i_interface_sinterface is
  port(-- clock
       clk : in std_logic;
       -- asynchronous reset: active high
       rst : in std_logic;
       i1  : in lightsensor_types.connstd;
       y   : out lightsensor_types.tup2_0);
end;

architecture structural of lightsensor_i_interface_sinterface is
  signal \#tup_case_alt\               : std_logic_vector(7 downto 0);
  signal ds1                           : std_logic_vector(7 downto 0);
  signal state                         : std_logic_vector(7 downto 0);
  signal ds2                           : std_logic;
  signal \#tup_case_alt_selection_res\ : boolean;
begin
  y <= ( tup2_0_sel0 => state
       , tup2_0_sel1 => ( connstd_sel0 => std_logic_vector'(x"00")
       , connstd_sel1 => '0'
       , connstd_sel2 => '0' ) );

  \#tup_case_alt_selection_res\ <= ds2 = ('1');

  \#tup_case_alt\ <= ds1 when \#tup_case_alt_selection_res\ else
                     state;

  ds1 <= i1.connstd_sel0;

  -- register begin 
  lightsensor_i_interface_sinterface_register : process(clk,rst)
  begin
    if rst = '1' then
      state <= std_logic_vector'(x"00")
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

  ds2 <= i1.connstd_sel1;
end;

