-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_testbench_types.all;
library lightsensor_topentity;

entity lightsensor_testbench is
  port(\dataOut\ : out std_logic_vector(7 downto 0));
end;

architecture structural of lightsensor_testbench is
  signal \#app_arg\    : std_logic;
  signal \#app_arg_0\  : std_logic;
  signal \#app_arg_1\  : std_logic;
  signal \#app_arg_2\  : std_logic;
  signal \#app_arg_3\  : std_logic;
  signal \#case_scrut\ : lightsensor_testbench_types.tup4;
  signal input_0       : std_logic;
  signal input_1       : std_logic;
  signal input_2       : std_logic;
  signal input_3       : std_logic;
  signal input_4       : std_logic;
  signal result        : lightsensor_testbench_types.tup4;
  signal result_0      : std_logic_vector(7 downto 0);
  signal result_1      : std_logic;
  signal result_2      : std_logic;
  signal result_3      : lightsensor_testbench_types.gatedclock;
begin
  lightsensor_stimuligenerator_app_arg : entity lightsensor_stimuligenerator
    port map
      ( result => \#app_arg\
      , clk    => \#app_arg_1\
      , rst    => \#app_arg_0\ );

  -- pragma translate_off
  \#app_arg_0\ <= '1',
             '0' after 2000 ps;
  -- pragma translate_on

  -- pragma translate_off
  clkgen : process is
    constant half_period : time := 90000 ps / 2;
  begin
    \#app_arg_1\ <= '0';
    wait for 3000 ps;
    while false loop
      \#app_arg_1\ <= not \#app_arg_1\;
      wait for half_period;
      \#app_arg_1\ <= not \#app_arg_1\;
      wait for half_period;
    end loop;
    wait;
  end process;
  -- pragma translate_on

  -- pragma translate_off
  \#app_arg_2\ <= '1',
             '0' after 2000 ps;
  -- pragma translate_on

  -- pragma translate_off
  clkgen_0 : process is
    constant half_period_0 : time := 90000 ps / 2;
  begin
    \#app_arg_3\ <= '0';
    wait for 3000 ps;
    while false loop
      \#app_arg_3\ <= not \#app_arg_3\;
      wait for half_period_0;
      \#app_arg_3\ <= not \#app_arg_3\;
      wait for half_period_0;
    end loop;
    wait;
  end process;
  -- pragma translate_on

  input_0 <= \#app_arg_3\;

  input_1 <= \#app_arg_2\;

  input_2 <= \#app_arg_1\;

  input_3 <= \#app_arg_0\;

  input_4 <= \#app_arg\;

  lightsensor_topentity_case_scrut : entity lightsensor_topentity.lightsensor_topentity
    port map
      ( \clkA\   => input_0
      , \rstA\   => input_1
      , \clkB\   => input_2
      , \rstB\   => input_3
      , miso     => input_4
      , result_0 => result_0
      , result_1 => result_1
      , result_2 => result_2
      , result_3 => result_3 );

  result <= ( tup4_sel0 => result_0
            , tup4_sel1 => result_1
            , tup4_sel2 => result_2
            , tup4_sel3 => result_3 );

  \#case_scrut\ <= result;

  \dataOut\ <= \#case_scrut\.tup4_sel0;
end;

