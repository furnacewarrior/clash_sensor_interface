-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_testbench_types.all;
library Test;

entity lightsensor_testbench is
  port(result : out std_logic_vector(7 downto 0));
end;

architecture structural of lightsensor_testbench is
  signal \#app_arg\   : std_logic_vector(7 downto 0);
  signal \#app_arg_0\ : std_logic;
  signal \#app_arg_1\ : std_logic;
  signal clk          : std_logic;
  signal rst          : std_logic;
  signal \in\         : Test.test_types.connstd;
  signal \out\        : std_logic_vector(7 downto 0);
begin
  clk <= \#app_arg_1\;

  rst <= \#app_arg_0\;

  \in\ <= Test.Test_types.fromSLV(lightsensor_testbench_types.toSLV(lightsensor_testbench_types.connstd'(( connstd_sel0 => \#app_arg\
          , connstd_sel1 => '0'
          , connstd_sel2 => '0' ))));

  test_result : entity Test.Test
    port map
      ( clk => clk
      , rst => rst
      , in  => \in\
      , out => \out\ );

  result <= \out\;

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
end;

