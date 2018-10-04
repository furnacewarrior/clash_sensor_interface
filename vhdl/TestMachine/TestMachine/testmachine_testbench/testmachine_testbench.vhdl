-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.testmachine_testbench_types.all;
library TestMachine;

entity testmachine_testbench is
  port(result : out unsigned(7 downto 0));
end;

architecture structural of testmachine_testbench is
  signal \#app_arg\   : unsigned(7 downto 0);
  signal \#app_arg_0\ : std_logic;
  signal \#app_arg_1\ : std_logic;
  signal clk          : std_logic;
  signal rst          : std_logic;
  signal input        : unsigned(7 downto 0);
  signal output       : unsigned(7 downto 0);
begin
  clk <= \#app_arg_1\;

  rst <= \#app_arg_0\;

  input <= \#app_arg\;

  testmachine_result : entity xil_defaultlib.TestMachine
    port map
      ( clk    => clk
      , rst    => rst
      , input  => input
      , output => output );

  result <= output;

  testmachine_stimuligenerator_app_arg : entity testmachine_stimuligenerator
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

