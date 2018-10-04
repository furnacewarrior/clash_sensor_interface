-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.spi_ctrl_types.all;

entity SPI_Ctrl is
  port(-- clock
       clk       : in std_logic;
       -- asynchronous reset: active high
       rst       : in std_logic;
       driverOut : in spi_ctrl_types.connstd;
       sensorOut : in std_logic;
       sensorIn  : out spi_ctrl_types.tup2_2;
       driverIn  : out spi_ctrl_types.connstd;
       -- gated clock
       clkOut    : out spi_ctrl_types.gatedclock);
end;

architecture structural of SPI_Ctrl is
  signal \#app_arg\ : spi_ctrl_types.gatedclock;
  signal y          : spi_ctrl_types.connstd;
  signal x          : std_logic;
  signal x_0        : std_logic;
  signal tup        : spi_ctrl_types.tup2_0;
  signal x_1        : std_logic;
  signal x_2        : spi_ctrl_types.tup3;
  signal spiIn      : spi_ctrl_types.tup2;
  signal res        : spi_ctrl_types.tup3_0;
begin
  spiIn <= ( tup2_sel0 => driverOut
           , tup2_sel1 => sensorOut );

  res <= ( tup3_0_sel0 => ( tup2_2_sel0 => x
         , tup2_2_sel1 => x_0 )
         , tup3_0_sel1 => y
         , tup3_0_sel2 => \#app_arg\ );

  -- clockGate begin
  \#app_arg\ <= (clk,((std_logic_vector'(0 => x_1)) = std_logic_vector'("1")));
  -- clockGate end

  y <= tup.tup2_0_sel1;

  x <= x_2.tup3_sel1;

  x_0 <= x_2.tup3_sel2;

  spi_ctrl_spictrl_sspictrl_tup : entity spi_ctrl_spictrl_sspictrl
    port map
      ( result => tup
      , clk    => clk
      , rst    => rst
      , input  => spiIn );

  x_1 <= x_2.tup3_sel0;

  x_2 <= tup.tup2_0_sel0;

  sensorIn <= res.tup3_0_sel0;

  driverIn <= res.tup3_0_sel1;

  clkOut <= res.tup3_0_sel2;
end;

