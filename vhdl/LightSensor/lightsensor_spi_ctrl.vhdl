-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_types.all;

entity lightsensor_spi_ctrl is
  port(-- clock
       clk    : in std_logic;
       -- asynchronous reset: active high
       rst    : in std_logic;
       input  : in lightsensor_types.tup2_1;
       result : out lightsensor_types.tup3_1);
end;

architecture structural of lightsensor_spi_ctrl is
  signal \#app_arg\ : lightsensor_types.gatedclock;
  signal y          : lightsensor_types.connstd;
  signal x          : std_logic;
  signal x_0        : std_logic;
  signal tup        : lightsensor_types.tup2_2;
  signal x_1        : std_logic;
  signal x_2        : lightsensor_types.tup3_0;
begin
  result <= ( tup3_1_sel0 => ( tup2_4_sel0 => x
            , tup2_4_sel1 => x_0 )
            , tup3_1_sel1 => y
            , tup3_1_sel2 => \#app_arg\ );

  -- clockGate begin
  \#app_arg\ <= (clk,((std_logic_vector'(0 => x_1)) = std_logic_vector'("1")));
  -- clockGate end

  y <= tup.tup2_2_sel1;

  x <= x_2.tup3_0_sel1;

  x_0 <= x_2.tup3_0_sel2;

  lightsensor_spictrl_tup : entity lightsensor_spictrl
    port map
      ( y     => tup
      , eta   => clk
      , eta_0 => rst
      , eta_1 => input );

  x_1 <= x_2.tup3_0_sel0;

  x_2 <= tup.tup2_2_sel0;
end;

