-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_types.all;

entity lightsensor_topentity is
  port(-- clock
       \clkA\   : in std_logic;
       -- asynchronous reset: active high
       \rstA\   : in std_logic;
       -- clock
       \clkB\   : in std_logic;
       -- asynchronous reset: active high
       \rstB\   : in std_logic;
       miso     : in std_logic;
       result_0 : out std_logic_vector(7 downto 0);
       result_1 : out std_logic;
       result_2 : out std_logic;
       -- gated clock
       result_3 : out lightsensor_types.gatedclock);
end;

architecture structural of lightsensor_topentity is
  signal x              : std_logic_vector(7 downto 0);
  signal y              : std_logic;
  signal x_0            : std_logic;
  signal \clkOut\       : lightsensor_types.gatedclock;
  signal tup            : lightsensor_types.tup2_0;
  signal ds             : lightsensor_types.tup3_1;
  signal \spiToSensor1\ : lightsensor_types.tup2_4;
  signal \syncToInt\    : lightsensor_types.connstd;
  signal y_0            : lightsensor_types.connstd;
  signal ds1            : lightsensor_types.tup2;
  signal tup1           : lightsensor_types.tup2;
  signal y_1            : lightsensor_types.connstd;
  signal x_1            : lightsensor_types.connstd;
  signal \syncToDriver\ : lightsensor_types.connstd;
  signal \spiToDriver\  : lightsensor_types.connstd;
  signal ds_fun_arg     : lightsensor_types.tup2_1;
  signal ds1_fun_arg    : lightsensor_types.tup2;
  signal tup1_fun_arg   : lightsensor_types.tup2;
  signal result         : lightsensor_types.tup4;
begin
  result <= ( tup4_sel0 => x
            , tup4_sel1 => y
            , tup4_sel2 => x_0
            , tup4_sel3 => \clkOut\ );

  x <= tup.tup2_0_sel0;

  y <= \spiToSensor1\.tup2_4_sel1;

  x_0 <= \spiToSensor1\.tup2_4_sel0;

  \clkOut\ <= ds.tup3_1_sel2;

  lightsensor_i_interface_sinterface_tup : entity lightsensor_i_interface_sinterface
    port map
      ( y   => tup
      , clk => \clkA\
      , rst => \rstA\
      , i1  => \syncToInt\ );

  ds_fun_arg <= ( tup2_1_sel0 => y_0
                , tup2_1_sel1 => miso );

  lightsensor_spi_ctrl_ds : entity lightsensor_spi_ctrl
    port map
      ( result => ds
      , clk    => \clkB\
      , rst    => \rstB\
      , input  => ds_fun_arg );

  \spiToSensor1\ <= ds.tup3_1_sel0;

  \syncToInt\ <= ds1.tup2_sel0;

  y_0 <= tup1.tup2_sel1;

  ds1_fun_arg <= ( tup2_sel0 => y_1
                 , tup2_sel1 => x_1 );

  lightsensor_synchronizer_ds1 : entity lightsensor_synchronizer
    port map
      ( result => ds1
      , \clkA\ => \clkA\
      , \rstA\ => \rstA\
      , \clkB\ => \clkB\
      , \rstB\ => \rstB\
      , ds1    => ds1_fun_arg );

  tup1_fun_arg <= ( tup2_sel0 => \syncToDriver\
                  , tup2_sel1 => \spiToDriver\ );

  lightsensor_ctrl_spi_lightsensor_tup1 : entity lightsensor_ctrl_spi_lightsensor
    port map
      ( y      => tup1
      , clk    => \clkB\
      , rst    => \rstB\
      , \#arg\ => tup1_fun_arg );

  y_1 <= tup.tup2_0_sel1;

  x_1 <= tup1.tup2_sel0;

  \syncToDriver\ <= ds1.tup2_sel1;

  \spiToDriver\ <= ds.tup3_1_sel1;

  result_0 <= result.tup4_sel0;

  result_1 <= result.tup4_sel1;

  result_2 <= result.tup4_sel2;

  result_3 <= result.tup4_sel3;
end;

