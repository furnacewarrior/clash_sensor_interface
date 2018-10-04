-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.spi_ctrl_testbench_types.all;
library SPI_Ctrl;

entity spi_ctrl_testbench is
  port(result : out spi_ctrl_testbench_types.tup2);
end;

architecture structural of spi_ctrl_testbench is
  signal ds1              : std_logic_vector(7 downto 0);
  signal ds2              : std_logic;
  signal driver           : spi_ctrl_testbench_types.connstd;
  signal \#ds_case_scrut\ : spi_ctrl_testbench_types.tup3_0;
  signal \#ds_app_arg\    : std_logic;
  signal \#ds_app_arg_0\  : std_logic;
  signal x                : std_logic;
  signal x_0              : std_logic_vector(7 downto 0);
  signal x_1              : std_logic;
  signal ds               : spi_ctrl_testbench_types.tup3;
  signal clk              : std_logic;
  signal rst              : std_logic;
  signal \spiIn\          : spi_ctrl_testbench_types.tup2_0;
  signal \driverOut\      : SPI_Ctrl.spi_ctrl_types.connstd;
  signal \sensorOut\      : std_logic;
  signal res              : spi_ctrl_testbench_types.tup3_0;
  signal \sensorIn\       : SPI_Ctrl.spi_ctrl_types.tup2_2;
  signal \driverIn\       : SPI_Ctrl.spi_ctrl_types.connstd;
  signal \clkOut\         : spi_ctrl_types.gatedclock;
begin
  ds1 <= driver.connstd_sel0;

  ds2 <= driver.connstd_sel1;

  driver <= \#ds_case_scrut\.tup3_0_sel1;

  clk <= \#ds_app_arg\;

  rst <= \#ds_app_arg_0\;

  \spiIn\ <= ( tup2_0_sel0 => ( connstd_sel0 => x_0
             , connstd_sel1 => x_1
             , connstd_sel2 => '0' )
             , tup2_0_sel1 => x );

  \driverOut\ <= SPI_Ctrl.SPI_Ctrl_types.fromSLV(spi_ctrl_testbench_types.toSLV(spi_ctrl_testbench_types.connstd'(\spiIn\.tup2_0_sel0)));

  \sensorOut\ <= \spiIn\.tup2_0_sel1;

  spi_ctrl_ds_case_scrut : entity SPI_Ctrl.SPI_Ctrl
    port map
      ( clk       => clk
      , rst       => rst
      , driverOut => \driverOut\
      , sensorOut => \sensorOut\
      , sensorIn  => \sensorIn\
      , driverIn  => \driverIn\
      , clkOut    => \clkOut\ );

  res <= ( tup3_0_sel0 => spi_ctrl_testbench_types.fromSLV(SPI_Ctrl.SPI_Ctrl_types.toSLV(\sensorIn\))
         , tup3_0_sel1 => spi_ctrl_testbench_types.fromSLV(SPI_Ctrl.SPI_Ctrl_types.toSLV(\driverIn\))
         , tup3_0_sel2 => spi_ctrl_testbench_types.fromSLV(SPI_Ctrl.SPI_Ctrl_types.toSLV(\clkOut\)) );

  \#ds_case_scrut\ <= res;

  -- pragma translate_off
  clkgen : process is
    constant half_period : time := 90000 ps / 2;
  begin
    \#ds_app_arg\ <= '0';
    wait for 3000 ps;
    while false loop
      \#ds_app_arg\ <= not \#ds_app_arg\;
      wait for half_period;
      \#ds_app_arg\ <= not \#ds_app_arg\;
      wait for half_period;
    end loop;
    wait;
  end process;
  -- pragma translate_on

  -- pragma translate_off
  \#ds_app_arg_0\ <= '1',
             '0' after 2000 ps;
  -- pragma translate_on

  x <= ds.tup3_sel2;

  x_0 <= ds.tup3_sel0;

  x_1 <= ds.tup3_sel1;

  spi_ctrl_stimuligenerator_ds : entity spi_ctrl_stimuligenerator
    port map
      ( result => ds
      , clk    => \#ds_app_arg\
      , rst    => \#ds_app_arg_0\ );

  result <= (tup2_sel0 => ds1, tup2_sel1 => ds2);
end;

