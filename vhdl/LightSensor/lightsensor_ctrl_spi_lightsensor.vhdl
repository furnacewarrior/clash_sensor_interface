-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_types.all;

entity lightsensor_ctrl_spi_lightsensor is
  port(-- clock
       clk    : in std_logic;
       -- asynchronous reset: active high
       rst    : in std_logic;
       \#arg\ : in lightsensor_types.tup2;
       y      : out lightsensor_types.tup2);
end;

architecture structural of lightsensor_ctrl_spi_lightsensor is
  signal result                               : lightsensor_types.tup5;
  signal \#tup_case_alt\                      : lightsensor_types.tup5;
  signal result_0                             : lightsensor_types.tup5;
  signal ds1                                  : std_logic_vector(7 downto 0);
  signal \stateL\                             : std_logic_vector(2 downto 0);
  signal \#spi_lightSensor#_$jOut_app_arg\    : std_logic_vector(2 downto 0);
  signal \buffer\                             : std_logic_vector(3 downto 0);
  signal state                                : lightsensor_types.tup5;
  signal ds2                                  : std_logic;
  signal \#spi_lightSensor#_$jOut_case_alt\   : std_logic_vector(2 downto 0);
  signal \#spi_lightSensor#_$jOut_case_alt_0\ : std_logic_vector(2 downto 0);
  signal \#spi_lightSensor#_$jOut_case_alt_1\ : std_logic_vector(2 downto 0);
  signal sync                                 : std_logic;
  signal finished                             : std_logic;
  signal \#spi_lightSensor#_$jOut_case_scrut\ : boolean;
  signal \inputSensor1\                       : lightsensor_types.connstd;
  signal \dataOut1\                           : std_logic_vector(7 downto 0);
begin
  y <= ( tup2_sel0 => ( connstd_sel0 => \dataOut1\
       , connstd_sel1 => sync
       , connstd_sel2 => '0' )
       , tup2_sel1 => ( connstd_sel0 => std_logic_vector'(x"00")
       , connstd_sel1 => finished
       , connstd_sel2 => '0' ) );

  with (\stateL\) select
    result <= \#tup_case_alt\ when "000",
              \#tup_case_alt\ when "001",
              result_0 when "010",
              \#tup_case_alt\ when "011",
              result_0 when "100",
              lightsensor_types.tup5'( std_logic_vector'(0 to 3 => '-'), std_logic_vector'(0 to 2 => '-'), std_logic_vector'(0 to 7 => '-'), '-', '-' ) when others;

  \#tup_case_alt\ <= result_0 when \#spi_lightSensor#_$jOut_case_scrut\ else
                     result_0;

  with (\#spi_lightSensor#_$jOut_app_arg\) select
    result_0 <= ( tup5_sel0 => \buffer\
                , tup5_sel1 => \#spi_lightSensor#_$jOut_app_arg\
                , tup5_sel2 => \dataOut1\
                , tup5_sel3 => '0'
                , tup5_sel4 => '0' ) when "000",
                ( tup5_sel0 => \buffer\
                , tup5_sel1 => \#spi_lightSensor#_$jOut_app_arg\
                , tup5_sel2 => \dataOut1\
                , tup5_sel3 => '0'
                , tup5_sel4 => '0' ) when "001",
                ( tup5_sel0 => ds1(3 downto 0)
                , tup5_sel1 => \#spi_lightSensor#_$jOut_app_arg\
                , tup5_sel2 => \dataOut1\
                , tup5_sel3 => '0'
                , tup5_sel4 => '0' ) when "010",
                ( tup5_sel0 => \buffer\
                , tup5_sel1 => \#spi_lightSensor#_$jOut_app_arg\
                , tup5_sel2 => \dataOut1\
                , tup5_sel3 => '0'
                , tup5_sel4 => '1' ) when "011",
                ( tup5_sel0 => \buffer\
                , tup5_sel1 => \#spi_lightSensor#_$jOut_app_arg\
                , tup5_sel2 => std_logic_vector'(std_logic_vector'(\buffer\) & std_logic_vector'((ds1(7 downto 4))))
                , tup5_sel3 => '1'
                , tup5_sel4 => '0' ) when "100",
                lightsensor_types.tup5'( std_logic_vector'(0 to 3 => '-'), std_logic_vector'(0 to 2 => '-'), std_logic_vector'(0 to 7 => '-'), '-', '-' ) when others;

  ds1 <= \inputSensor1\.connstd_sel0;

  \stateL\ <= state.tup5_sel1;

  with (\stateL\) select
    \#spi_lightSensor#_$jOut_app_arg\ <= \#spi_lightSensor#_$jOut_case_alt\ when "000",
                                         \#spi_lightSensor#_$jOut_case_alt_0\ when "001",
                                         std_logic_vector'("011") when "010",
                                         \#spi_lightSensor#_$jOut_case_alt_1\ when "011",
                                         std_logic_vector'("000") when others;

  \buffer\ <= state.tup5_sel0;

  -- register begin 
  lightsensor_ctrl_spi_lightsensor_register : process(clk,rst)
  begin
    if rst = '1' then
      state <= ( tup5_sel0 => std_logic_vector'(x"0"), tup5_sel1 => std_logic_vector'("000"), tup5_sel2 => std_logic_vector'(x"00"), tup5_sel3 => '0', tup5_sel4 => '0' )
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(clk) then
      state <= result
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  ds2 <= \inputSensor1\.connstd_sel1;

  \#spi_lightSensor#_$jOut_case_alt\ <= std_logic_vector'("001") when \#spi_lightSensor#_$jOut_case_scrut\ else
                                        std_logic_vector'("000");

  \#spi_lightSensor#_$jOut_case_alt_0\ <= std_logic_vector'("010") when \#spi_lightSensor#_$jOut_case_scrut\ else
                                          std_logic_vector'("001");

  \#spi_lightSensor#_$jOut_case_alt_1\ <= std_logic_vector'("100") when \#spi_lightSensor#_$jOut_case_scrut\ else
                                          std_logic_vector'("011");

  sync <= state.tup5_sel3;

  finished <= state.tup5_sel4;

  \#spi_lightSensor#_$jOut_case_scrut\ <= ds2 = ('1');

  \inputSensor1\ <= \#arg\.tup2_sel1;

  \dataOut1\ <= state.tup5_sel2;
end;

